const std = @import("std");
const expect = std.testing.expect;
fn add(x: i8, y: i8) i8 {
    return x + y;
}
pub fn main() !void {}

test "add function" { // single test super simple
    try expect(add(23, 23) == 46);
    try expect(add(3, 3) == 6);
    try expect(add(2, 2) == 4);
    try expect(add(6, 4) == 10);
    try expect(add(6, 14) == 20);
}


test ""
