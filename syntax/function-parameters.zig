const std = @import("std");
const stdout = std.io.getStdOut().writer();

fn add(x: *u32) void {
    // x = x + 2; this can't be done

    // const y: u32 = x + 2; this is good way but not great
    // return y;
    // const d: u32 = 4;
    x.* = x.* + 4;
}

pub fn main() !void {
    var y: u32 = 4;
    add(&y);
    std.debug.print("{d} \n", .{y});
}
