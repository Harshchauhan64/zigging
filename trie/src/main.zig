const std = @import("std");
const Trie = @import("trie.zig").Trie;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var trie = try Trie.init(allocator); // 1st
    defer trie.deinit();

    try trie.insert("apple");
    std.debug.print("search apple {}\n", .{(&trie).search("apple")});
    std.debug.print("search app {}\n", .{(&trie).search("app")});
    std.debug.print("startsWith app {}\n", .{(&trie).startsWith("app")});
    try trie.insert("app");
    std.debug.print("search app {}\n", .{(&trie).search("app")});
}
