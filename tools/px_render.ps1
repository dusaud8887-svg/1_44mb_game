# px_render.ps1 - .px 텍스트 그리드를 PNG로 렌더(검수용)하고 C 배열(2bpp)로 내보낸다.
# 사용법:
#   powershell -File tools\px_render.ps1 -Path assets\px\echo_16.px            # PNG 렌더 (기본 12배)
#   powershell -File tools\px_render.ps1 -Path assets\px\echo_16.px -EmitC     # C 배열 출력
# .px 포맷:
#   '#'로 시작하는 줄은 메타데이터. 팔레트 줄: "# palette: 1=RRGGBB 2=RRGGBB 3=RRGGBB"
#   그리드 문자: '.'=0(투명), '1','2','3'=팔레트 인덱스. 모든 행은 같은 길이.
param(
    [Parameter(Mandatory=$true)][string]$Path,
    [int]$Scale = 12,
    [string]$Out,
    [switch]$EmitC
)
$ErrorActionPreference = 'Stop'
trap { Write-Output $_.InvocationInfo.PositionMessage; Write-Output $_.Exception.Message; exit 2 }
Add-Type -AssemblyName System.Drawing

$palette = @{}
$grid = @()
foreach ($ln in (Get-Content $Path)) {
    if ($ln -match '^\s*#') {
        if ($ln -match 'palette:\s*(.+)$') {
            foreach ($tok in ($Matches[1].Trim() -split '\s+')) {
                if ($tok -match '^([123])=([0-9a-fA-F]{6})$') {
                    $palette[$Matches[1]] = $Matches[2]
                }
            }
        }
    } elseif ($ln.Trim().Length -gt 0) {
        $grid += ,$ln.TrimEnd()
    }
}
if ($grid.Count -eq 0) { throw "no grid rows in $Path" }
[int]$h = $grid.Count
[int]$w = ([string]$grid[0]).Length
foreach ($row in $grid) { if (([string]$row).Length -ne $w) { throw "row length mismatch: '$row' ($(([string]$row).Length) != $w)" } }

function HexColor([string]$hex) {
    [System.Drawing.Color]::FromArgb(255,
        [Convert]::ToInt32($hex.Substring(0,2),16),
        [Convert]::ToInt32($hex.Substring(2,2),16),
        [Convert]::ToInt32($hex.Substring(4,2),16))
}

if ($EmitC) {
    $name = [IO.Path]::GetFileNameWithoutExtension($Path) -replace '[^A-Za-z0-9_]','_'
    $bytes = @()
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x += 4) {
            $b = 0
            for ($k = 0; $k -lt 4; $k++) {
                $c = if ($x + $k -lt $w) { $grid[$y][$x + $k] } else { '.' }
                $v = if ($c -eq '.') { 0 } else { [int]::Parse([string]$c) }
                $b = ($b -shl 2) -bor $v
            }
            $bytes += $b
        }
    }
    $stride = [Math]::Ceiling($w / 4.0)
    Write-Output "/* $name  ${w}x${h}  2bpp MSB-first, $($bytes.Count) bytes */"
    Write-Output "static const uint8_t PX_$($name.ToUpper())[$($bytes.Count)] = {"
    for ($i = 0; $i -lt $bytes.Count; $i += $stride) {
        $rowBytes = $bytes[$i..([Math]::Min($i+$stride-1,$bytes.Count-1))]
        Write-Output ("    " + (($rowBytes | ForEach-Object { "0x{0:X2}," -f $_ }) -join ""))
    }
    Write-Output "};"
    exit 0
}

if (-not $Out) { $Out = [IO.Path]::ChangeExtension($Path, ".png") }
$bw = $w * $Scale; $bh = $h * $Scale
$bmp = New-Object System.Drawing.Bitmap $bw, $bh
$gfx = [System.Drawing.Graphics]::FromImage($bmp)
$checkA = HexColor '2a2a34'; $checkB = HexColor '1e1e26'
for ($y = 0; $y -lt $h; $y++) {
    for ($x = 0; $x -lt $w; $x++) {
        $c = $grid[$y][$x]
        if ($c -eq '.') {
            $col = if ((($x + $y) % 2) -eq 0) { $checkA } else { $checkB }
        } elseif ($palette.ContainsKey([string]$c)) {
            $col = HexColor $palette[[string]$c]
        } else {
            throw "grid char '$c' at ($x,$y) has no palette entry"
        }
        $brush = New-Object System.Drawing.SolidBrush($col)
        $gfx.FillRectangle($brush, $x * $Scale, $y * $Scale, $Scale, $Scale)
        $brush.Dispose()
    }
}
$gfx.Dispose()
$bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Output "rendered $Out (${w}x${h} @ ${Scale}x)"
