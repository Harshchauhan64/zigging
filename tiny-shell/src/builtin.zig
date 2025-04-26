const std = @import("std");

pub fn executeCommand(allocator: std.mem.Allocator, command: []const u8) !void {
    if (command.len == 0) return;

    var args = std.ArrayList([]const u8).init(allocator);
    defer args.deinit();

    var it = std.mem.tokenizeScalar(u8, command, " ");
    while (it.next()) |arg| {
        try args.append(arg);
    }
    if (args.items.len == 0) {
        return;
    }

    if (std.mem.eql(u8, args.items[0], "cd")) {
        if (args.items.len < 2) {
            const home = std.os.getenv("HOME") orelse return error.HomeNotFound;
            try std.os.chdir(args.items[1]);
        }
    
}
