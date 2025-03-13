const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;
const expectError = std.testing.expectError;

fn alloc_error(allocator: Allocator) !void {
    var ibuffer = try allocator.alloc(u8, 100); // allocated some memory
    defer allocator.free(ibuffer); // freed it up
    ibuffer[0] = 4;
}

fn memory_leak(allocator: Allocator) !void {
    const buffer = try allocator.alloc(u32, 30);
    // there is memory leak as we don't free this up
    // using test lets try to catch this
    defer allocator.free(buffer); // comment this out and discard the buffer for the memory leak to occur
}

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

test "allocator test " {
    const allocator = std.testing.allocator;
    try memory_leak(allocator);
}

test "allocaton memory overbound test" {
    var buffer: [10]u8 = undefined; // array of 10 elements
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    try expectError(error.OutOfMemory, alloc_error(allocator));
}
test "values are equal?" {
    const v1 = 15;
    const v2 = 15; // change this to fail the test basic equality test
    try std.testing.expectEqual(v1, v2); // here its just testing whether both are equal or not.
}

test "arrays are equal?" {
    const array1 = [3]u32{ 1, 2, 3 };
    const array2 = [3]u32{ 1, 2, 3 };
    try std.testing.expectEqualSlices(u32, &array1, &array2);
}
test "strings are equal?" {
    const str1 = "Hello, world!";
    const str2 = "Hello, world!";
    try std.testing.expectEqualStrings(str1, str2);
}
