const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const v1 = @Vector(4, u32){ 4, 12, 37, 9 };
    const v2 = @Vector(4, u32){ 10, 22, 5, 12 };
    const v3 = v1 + v2; // simd operations
    try stdout.print("{any}\n", .{v3});
    // its hard to tell its done on vectors (simd)
}
