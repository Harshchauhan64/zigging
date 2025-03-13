const std = @import("std");
const stdout = std.io.getStdOut().writer();
const expect = std.testing.expect;
fn add(x: u8, y: u8) u8 {
    return x + y;
}

fn add_and_increment(a: u8, b: u8) u8 {
    const sum = a + b;
    const incremented = sum + 1;
    return incremented;
}

pub fn main() !void {
    const result = add(54, 54);
    std.debug.print("reault: {d}", .{result}); // this prints throught the stderr stream
    // if we want to use debuggar then we have to use debug mode
    var n = add_and_increment(2, 3);
    n = add_and_increment(n, n);
    try stdout.print("/n Result: {d}!n", .{n});
    try stdout.print("{any}/n", .{@TypeOf(n)});
}
