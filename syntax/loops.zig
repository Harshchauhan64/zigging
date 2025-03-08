const std = @import("std");

const stdout = std.io.getStdOut().writer();

fn add(x: *u32) void {
    const d: u32 = 56;
    x.* = x.* + d;
}

pub fn main() !void {
    const alphabet = [_]u8{ 'A', 'B', 'C', 'D', 'E' };
    for (alphabet) |char| {
        try stdout.print("{d} | ", .{char});
    }
    // function parameters are immutable
    // just send the reference.
    var x: u32 = 3;
    add(&x);
    std.debug.print("\nResult: {d}\n", .{x});
}
