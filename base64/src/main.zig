/// Jotted everything here for now
/// will modularize it later
const std = @import("std");
const stdout = std.io.getStdOut().writer();

const Base64 = struct {
    table: [64]u8, // 64 characters

    pub fn init() Base64 {
        var b64 = Base64{
            .table = undefined,
        };

        const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        for (chars, 0..) |c, i| { // need mem.cmp
            b64.table[i] = c; // gonna read tomorrow about it
            // for now brute is the way
        }

        return b64;
    }

    pub fn charAt(self: Base64, index: usize) u8 {
        return self.table[index];
    }

    pub fn charIndex(self: Base64, char: u8) u8 {
        if (char == '=') {
            return 64;
        }

        for (self.table, 0..) |c, i| {
            if (c == char) return @intCast(i);
        }

        return 64;
    }

    pub fn encode(self: *const Base64, allocator: std.mem.Allocator, input: []const u8) ![]u8 {
        if (input.len == 0) {
            return allocator.alloc(u8, 0);
        }

        const n_out = try calcEncodeLength(input);
        var out = try allocator.alloc(u8, n_out);
        var buf = [3]u8{ 0, 0, 0 };
        var count: u8 = 0;
        var iout: usize = 0;

        for (input) |byte| {
            buf[count] = byte;
            count += 1;
            if (count == 3) {
                out[iout] = self.charAt(buf[0] >> 2);
                out[iout + 1] = self.charAt(((buf[0] & 0x03) << 4) | (buf[1] >> 4));
                out[iout + 2] = self.charAt(((buf[1] & 0x0f) << 2) | (buf[2] >> 6));
                out[iout + 3] = self.charAt(buf[2] & 0x3f);
                iout += 4;
                count = 0;
            }
        }

        if (count == 1) {
            out[iout] = self.charAt(buf[0] >> 2);
            out[iout + 1] = self.charAt((buf[0] & 0x03) << 4);
            out[iout + 2] = '=';
            out[iout + 3] = '=';
        } else if (count == 2) {
            out[iout] = self.charAt(buf[0] >> 2);
            out[iout + 1] = self.charAt(((buf[0] & 0x03) << 4) | (buf[1] >> 4));
            out[iout + 2] = self.charAt((buf[1] & 0x0f) << 2);
            out[iout + 3] = '=';
        } // idk what I did in above shit
        return out;
    }

    pub fn decode(self: *const Base64, allocator: std.mem.Allocator, input: []const u8) ![]u8 {
        if (input.len == 0) {
            return allocator.alloc(u8, 0);
        }

        const n_output = try calcDecodeLength(input);
        var output = try allocator.alloc(u8, n_output);

        var count: u8 = 0;
        var iout: usize = 0;
        var buf = [4]u8{ 0, 0, 0, 0 };

        for (input) |char| {
            buf[count] = self.charIndex(char);
            count += 1;

            if (count == 4) {
                if (buf[0] < 64 and buf[1] < 64) {
                    output[iout] = (buf[0] << 2) | (buf[1] >> 4);
                    iout += 1;

                    if (buf[2] < 64) {
                        output[iout] = ((buf[1] & 0x0f) << 4) | (buf[2] >> 2);
                        iout += 1;

                        if (buf[3] < 64) {
                            output[iout] = ((buf[2] & 0x03) << 6) | buf[3];
                            iout += 1;
                        }
                        // don't know what happenedd here but yah
                    }
                }
                count = 0;
            }
        }
        return output[0..iout]; // return slice
    }
};

fn calcEncodeLength(input: []const u8) !usize {
    return ((input.len + 2) / 3) * 4; // simple implementation
}

fn calcDecodeLength(input: []const u8) !usize {
    var padding: usize = 0;
    if (input.len > 0 and input[input.len - 1] == '=') padding += 1;
    if (input.len > 1 and input[input.len - 2] == '=') padding += 1;

    return (input.len / 4) * 3 - padding;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const text = "testing some shit"; // enncoded later
    const etext = "VGhlIFppZyBsYW5n";

    const base64 = Base64.init();

    const encoded_text = try base64.encode(allocator, text);
    defer allocator.free(encoded_text);

    const decoded_text = try base64.decode(allocator, etext);
    defer allocator.free(decoded_text);

    try stdout.print("Encoded text: {s}\n", .{encoded_text});
    try stdout.print("Decoded text: {s}\n", .{decoded_text});
}
