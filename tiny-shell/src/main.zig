//! TODO: alot of things
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var input_buffer = std.ArrayList(u8).init(allocator);
    defer input_buffer.deinit();

    while (true) {
        try stdout.print("zig> ", .{});

        input_buffer.clearRetainingCapacity();
        try stdin.readUntilDelimiterArrayList(&input_buffer, '\n', 1024);

        const input = input_buffer.items;

        if (std.mem.eql(u8, input, "exit")) {
            break;
        }

        const result = try executeCommand(allocator, input);
        try stdout.print("{s}", .{result});
    }
}

fn executeCommand(allocator: std.mem.Allocator, command: []const u8) ![]const u8 {
    _ = command;
    return try std.fmt.allocPrint(allocator, "Command not implemented yet\n", .{});
}
