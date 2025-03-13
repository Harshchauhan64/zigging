const std = @import("std");
const stdout = std.io.getStdOut().writer();
const base64_module = @import("base64.zig"); // i have to import then split in module
const Base64 = base64_module.Base64; // here module splite
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const text = "testing some shit"; // enncoded later
    const etext = "VGhlIFppZyBsYW5n";

    const base64 = Base64.init();

    const encoded_text = try base64.encode(allocator, text);
    defer allocator.free(encoded_text); // I forgot this once

    const decoded_text = try base64.decode(allocator, etext);
    defer allocator.free(decoded_text);

    try stdout.print("Encoded text: {s}\n", .{encoded_text});
    try stdout.print("Decoded text: {s}\n", .{decoded_text});
}

test "ecnoding/decoding" {
    const allocator = std.testing.allocator;
    const base64 = Base64.init();
    const text = "woow there is testing allocator too";
    const encoded = try base64.encode(allocator, text);
    defer allocator.free(encoded);
    try std.testing.expectStringEndsWith("d29vdyB0aGVyZSBpcyB0ZXN0aW5nIGFsbG9jYXRvciB0b28=", encoded);
}
