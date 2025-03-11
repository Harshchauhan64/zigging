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
    const arr = [5]i8{ 1, 2, 3, 4, 5 }; // array of size 5 but auto no. by using _
    const plus = arr ++ array;
    const slice = array[0..2]; // this is not a proper slice but a pointer to an array see print third below
    try stdout.print("{d}\n", .{plus});
    try stdout.print("{d}\n", .{arr[4]});
    try stdout.print("type: {any} \n", .{@TypeOf(slice)});
    var end: usize = 4;
    end += 1;
    var realSlice = arr[1..end];
    try stdout.print("type: {any} \n", .{@TypeOf(realSlice)}); // now this is realslice
    realSlice[2] = 99;
}
