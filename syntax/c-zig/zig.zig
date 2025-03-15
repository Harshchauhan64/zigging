const c = @import("c.zig");
pub fn main() !void {
    const x: f32 = 3.141592653589793238462643383279502884197;
    _ = c.printf("%.3f\n", x);
}
