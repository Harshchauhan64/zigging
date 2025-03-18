const std = @import("std");

const TrieNode = struct {
    child: [26]?*TrieNode,
    term: bool,

    pub fn init(allocator: std.mem.Allocator) !*TrieNode {
        const node = try allocator.create(TrieNode);
        node.* = TrieNode{
            .child = [_]?*TrieNode{null} ** 26,
            .term = false,
        };
        return node;
    }

    pub fn deinit(self: *TrieNode, allocator: std.mem.Allocator) void {
        for (self.child) |child_opt| {
            if (child_opt) |child| {
                child.deinit(allocator);
            }
        }
        allocator.destroy(self);
    }
};

pub const Trie = struct {
    root: *TrieNode,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !Trie {
        return Trie{
            .root = try TrieNode.init(allocator),
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Trie) void {
        self.root.deinit(self.allocator);
    }

    pub fn insert(self: *Trie, word: []const u8) !void {
        var current = self.root;

        for (word) |char| {
            const index = char - 'a';
            if (index >= 26) return error.InvalidCharacter;

            if (current.child[index] == null) {
                current.child[index] = try TrieNode.init(self.allocator);
            }

            // Move to the child node
            current = current.child[index].?;
        }

        // Mark the end of the word
        current.term = true;
    }

    // Search for a word in the Trie
    pub fn search(self: *Trie, word: []const u8) bool {
        var current = self.root;

        for (word) |char| {
            const index = char - 'a';
            if (index >= 26) return false;

            if (current.child[index] == null) {
                return false;
            }

            current = current.child[index].?;
        }

        return current.term;
    }

    pub fn startsWith(self: *Trie, word: []const u8) bool {
        var current = self.root;

        for (word) |char| {
            const index = char - 'a';
            if (index >= 26) return false;

            if (current.child[index] == null) {
                return false;
            }

            current = current.child[index].?;
        }

        return true;
    }
};
