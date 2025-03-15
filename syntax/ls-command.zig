const std = @import("std");
const allocator = std.heap.page_allocator;

const stdout = std.io.getStdOut().writer();
pub fn main() !void {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    const path = if (args.len > 1) args[1] else ".";
    var dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    defer dir.close();

    var it = dir.iterate();
    while (try it.next()) |entry| {
        try stdout.print("{s}\n", .{entry.name});
    }
}
