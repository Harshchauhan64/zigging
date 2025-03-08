const std = @import("std");
const stdout = std.io.getStdOut().writer();
const Role = enum { SE, DPE, DA, PM, PO, KS };

pub fn main() !void {
    const x = true;
    if (!x) { // simple if and else statements
        _ = try stdout.write("Not x");
    } else {
        _ = try stdout.write("maybe x\n");
    }
    const role = Role.PO;
    var words: []const u8 = undefined;
    switch (role) {
        .DPE,
        .DA,
        => {
            words = "D";
        },
        .SE, .PM, .PO => {
            words = "P";
        },
        .KS => {
            words = "K";
        },
        // all the cases must ne exhausted therefore can't use else here.
    }
    try stdout.print("{s}\n", .{words});
    try foo();
}

fn foo() !void {
    defer std.debug.print("Ran at the end of the function scope exiting", .{});
    // brother of defer is also like defer but a condtional one; only running when error is occured
    try stdout.print("Something happening \n", .{});
}
