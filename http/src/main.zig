//! using socket for the building basic server
const std = @import("std");

const SocketConf = @import("socket.zig");
const Request = @import("request.zig");
const Response = @import("respone.zig");
const Method = Request.Method;
const stdout_file = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try SocketConf.Socket.init();
    var server = try socket._address.listen(.{});
    std.debug.print("Server Address: {any}\n", .{socket._address});
    const connection = try server.accept();

    var buffer: [1000]u8 = undefined; // empty buffer with zeros
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }
    try Request.read_request(connection, buffer[0..buffer.len]); // lets go this works
    const request = Request.parse_request(buffer[0..buffer.len]);
    if (request.method == Method.GET) {
        if (std.mem.eql(u8, request.uri, "/")) {
            try Response.send_200(connection);
        } else {
            try Response.send_404(connection);
        }
    }
}
