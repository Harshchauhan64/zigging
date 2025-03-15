const c = @cImport({
    @cDefine("_NO_CRT_STDIO_INLINE", "1");
    @cInclude("stdio.h");
    @cInclude("math.h");
});

pub fn main() !void {
    const x: i32 = 2;
    const y = c.pow(x, @as(f32, 2));
    _ = c.printf("  %.2f", y);
}
