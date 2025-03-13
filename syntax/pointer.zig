const std = @import("std");

pub fn main() !void {
    var number: u8 = 2;
    const pointer = &number; // ptr
    const double = 2 * pointer.*;
    pointer.* = 6;
    std.debug.print("{d}\n", .{double});
    std.debug.print("{d}\n", .{number});
}
