const std = @import("std");
const Connection = std.net.Server.Connection;

pub fn send_200(conn: Connection) !void {
    const message = ("HTTP/1.1 200 OK \nContent length: 50" ++ "\nContent-type: text/html\n" ++ "Connection:Closed\n\n <html> <body style=\"background-color:black\">" ++ "<h1 style=\"color:white;\"> I'm Depressed</h1></body></html>"); // i don't know what is formatting this shit wrong
    _ = try conn.stream.write(message);
} // terrible way to do this but we ball
pub fn send_404(conn: Connection) !void {
    const message = ("HTTP/1.1 404 Not Found\nContent length: 50" ++ "\nContent-type: text/html\n" ++ "Connection:Closed\n\n <html> < body style:\"background-color:black\"" ++ "<h1 style:\"color:white\"> I'm not Depressed</h1></body></html>"); // i don't know what is formatting this shit wrong
    _ = try conn.stream.write(message); // autofix
    //
}
