const std = @import("std");

const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){}; // get a allocator
    const allocator = gpa.allocator(); // get a allocator
    const name = "harsh";
    const output = try std.fmt.allocPrint(allocator, "Hello {s}!!!", .{name});
    try stdout.print("{s}\n", .{output});
}
