"""Summarize DEV_LOG playtest CSV files using only the Python standard library."""

import csv
import statistics
import sys
from pathlib import Path


def summarize(paths):
    runs = {}
    testers = set()
    for name in paths:
        path = Path(name)
        with path.open(encoding="utf-8", newline="") as source:
            reader = csv.DictReader(source)
            required = {"run", "seed", "tick", "event", "tx", "rx", "choice_mask", "bought_mask", "auto_cued", "result", "cheated"}
            missing = required - set(reader.fieldnames or ())
            if missing:
                raise SystemExit(f"{path}: unsupported playtest schema (missing {', '.join(sorted(missing))})")
            session = 0
            previous = None
            for row in reader:
                signature = (row["run"], row["seed"])
                tick = int(row["tick"])
                if previous is None or signature != previous[0] or tick < previous[1]:
                    session += 1
                previous = (signature, tick)
                key = (str(path.resolve()), session)
                runs.setdefault(key, []).append(row)
                testers.add(str(path.resolve()))

    valid = [rows for rows in runs.values() if not any(int(row["cheated"]) for row in rows)]
    first_air = [int(next(row["tick"] for row in rows if row["event"] == "on_air")) / 60 for rows in valid if any(row["event"] == "on_air" for row in rows)]
    air = [row for rows in valid for row in rows if row["event"] == "on_air"]
    results = [row for rows in valid for row in rows if row["event"] == "result"]
    mixed = sum(int(row["tx"]) > 0 and int(row["rx"]) > 0 for row in air)
    auto = sum(int(row["auto_cued"]) for row in air)
    bought = sum(int(row["bought_mask"]) != 0 for row in air)
    choices = len({(row["intent"], row["choice_mask"]) for row in air})

    print(f"testers(files): {len(testers)}  runs: {len(runs)}  valid: {len(valid)}  cheated: {len(runs)-len(valid)}")
    print(f"first ON AIR median: {statistics.median(first_air):.1f}s" if first_air else "first ON AIR median: n/a")
    print(f"turns: {len(air)}  mixed TX/RX: {mixed}/{len(air)}  auto-cued: {auto}/{len(air)}")
    print(f"turns after any purchase: {bought}/{len(air)}  intent/choice pairs: {choices}")
    print(f"results: {len(results)}  wins: {sum(int(row['result']) == 1 for row in results)}")
    enough = len(testers) >= 5 and len(valid) >= 10
    print("GV2 data volume: " + ("READY" if enough else "INSUFFICIENT (need 5 tester files and 10 valid runs)"))
    return 0 if enough else 2


def self_test():
    import tempfile
    header = "run,seed,tick,event,turn,intent,deck,tx,rx,cued,choice_mask,bought_mask,auto_cued,hp,live,archived,mimicked,trend,result,cheated\n"
    row = "1,1,60,on_air,1,0,10,1,1,1,4,0,0,5,0,0,0,4,0,0\n"
    with tempfile.TemporaryDirectory() as folder:
        paths = []
        for index in range(5):
            path = Path(folder) / f"P{index}.csv"
            path.write_text(header + row + row.replace("1,1,60", "2,2,120"), encoding="utf-8")
            paths.append(path)
        assert summarize(paths) == 0
    print("playtest_report self-test: PASS")


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
    elif not sys.argv[1:]:
        print("usage: build.bat report P01.csv P02.csv ...", file=sys.stderr)
        raise SystemExit(2)
    else:
        raise SystemExit(summarize(sys.argv[1:]))
