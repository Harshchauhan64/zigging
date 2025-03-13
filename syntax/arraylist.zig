//! dynamic arrays in zig
const std = @import("std");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    try stdout.print("Capacity: {d}\t Length: {d}\n", .{ buffer.capacity, buffer.items.len });
    for (0..10) |i| {
        const index: u8 = @intCast(i);
        try buffer.append(index);
    }
    std.debug.print("{any}\n", .{buffer.items}); // full array print with this
    _ = buffer.orderedRemove(3);
    _ = buffer.orderedRemove(3);

    std.debug.print("{any}\n", .{buffer.items});
    std.debug.print("{any}\n", .{buffer.items.len});
    defer buffer.deinit();
}
