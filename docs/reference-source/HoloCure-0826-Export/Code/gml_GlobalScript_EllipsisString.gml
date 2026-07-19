function EllipsisString()
{
    var elapsed = current_time % 2000;
    return string_repeat(".", clamp(ceil(elapsed / 666.6666666666666), 1, 3));
}
