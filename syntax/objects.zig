const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var age: u8 = 12; // mutable
    age = 12;
    const id = 11; // immutable
    _ = id;
    var undefinedVar: i32 = undefined;
    undefinedVar = 123; // undefined and have to mutate as per the rule
    const array = [_]i8{ 1, 2, 3, 4, 5 }; // array of size 5 but auto no. by using _
    _ = array; // autofix
    const arr = [5]i8{ 1, 2, 3, 4, 5 }; // array of size 5 but auto no. by using _
    try stdout.print("{d}/n", .{arr[4]});
}
