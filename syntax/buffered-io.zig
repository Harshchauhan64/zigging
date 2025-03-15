const std = @import("std");
const stdout = std.io.getStdOut().writer();
pub fn main() !void {
    var file = try std.fs.cwd().openFile("test.txt", .{});
    defer file.close();
    var buffered = std.io.bufferedReader(file.reader());
    var bufreader = buffered.reader();

    var buffer: [1000]u8 = undefined;
    @memset(buffer[0..], 0);

    _ = try bufreader.readUntilDelimiterOrEof(buffer[0..], '\n');
    try stdout.print("{s}\n", .{buffer});
}
