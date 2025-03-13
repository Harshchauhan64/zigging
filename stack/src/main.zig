const std = @import("std");
const Allocator = std.mem.Allocator;

fn Stack(comptime T: type) type {
    return struct {
        items: []T,
        capacity: usize,
        length: usize,
        allocator: Allocator,
        const Self = @This(); // why this I have to understand this

        pub fn init(allocator: Allocator, capacity: usize) !Stack(T) {
            var buf = try allocator.alloc(T, capacity);
            return .{
                .items = buf[0..],
                .capacity = capacity,
                .length = 0, // think about this for sec here we are not having anything init so zero
                .allocator = allocator,
            };
        }
        pub fn push(self: *Self, val: T) !void {
            if (self.length + 1 > self.capacity) { // if the length is almost full the we have to move the allocation to larger block of memory
                var new_buf = try self.allocator.alloc(T, self.capacity * 2); // create new memory block with twice the capacity
                @memcpy(new_buf[0..self.capacity], self.items); // copy over the items in the capacity of the last block
                self.allocator.free(self.items); // free the items (previous block of mem)
                self.items = new_buf; // item are now in new_buf
                self.capacity *= 2; // capacity twice
            }
            self.items[self.length] = val; // length will be the first one (zero)
            self.length += 1; // increment
        }

        pub fn pop(self: *Self) !void { // undefind the last element and decrease the length
            if (self.length == 0) return;
            self.items[self.length - 1] = undefined;
            self.length -= 1;
        }

        pub fn peek(self: *Self) ?T {
            if (self.length == 0) {
                return null;
            }
            return self.items[self.length - 1];
        }

        pub fn deinit(self: *Self) void {
            self.allocator.free(self.items);
        }
    };
}
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const stacki8 = Stack(i8);
    var stack = try stacki8.init(allocator, 10);
    try stack.push(1);
    std.debug.print("Peek: {any}\n", .{stack.peek()});

    try stack.push(2);
    std.debug.print("Peek: {any}\n", .{stack.peek()});

    try stack.push(3);
    std.debug.print("Peek: {any}\n", .{stack.peek()});

    std.debug.print("Stack len: {d}\n", .{stack.length});
    std.debug.print("Stack capacity: {d}\n", .{stack.capacity});

    try stack.pop();
    std.debug.print("Stack len: {d}\n", .{stack.length});
    try stack.pop();
    std.debug.print("Stack len: {d}\n", .{stack.length});
    std.debug.print("Stack state: {any}\n", .{stack.items[0..stack.length]});

    defer stack.deinit();
}
