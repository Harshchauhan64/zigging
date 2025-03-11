const std = @import("std");

const stdout = std.io.getStdOut().writer();
// struct declaration must be const
const User = struct { // if you need to use outside this module then use pub const
    id: u64,
    name: []const u8,
    email: []const u8,
    fn init(id: u64, name: []const u8, email: []const u8) User { // constructor
        return User{
            .id = id,
            .name = name,
            .email = email,
        };
    }
    fn print_email(self: User) !void { // methods
        try stdout.print("{s}\n", .{self.email});
    }
    fn print_name(self: User) !void { // you need to make methods pub too if you want to use outside of the module
        try stdout.print("{s}\n", .{self.name});
    }
};

pub fn main() !void {
    const u = User.init(1, "Tammer", "tammer@gamil.com");
    try u.print_name();
    try u.print_email();

    const eu = User{
        .email = "name@gmail.com",
        .id = 2,
        .name = "tros",
    };
    _ = eu; // autofix
}
