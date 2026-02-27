const std = @import("std");
const builtin = @import("builtin");

pub const MAX_COMMANDS: u8 = 10;
pub const MAX_OPTIONS: u8 = 20;

const Byte = u8;
const Slice = []const Byte;
const Slices = []const Slice;

pub const command = struct {
    name: Slice,                                    // name of the command
    func: fnType,                                   // function to execute the command
    req: Slices = &.{},                             // required options
    opt: Slices = &.{},                             // optional options
    const fnType = *const fn([]const option) bool;
};

pub const option = struct {
    name: Slice,                                    // name of the option
    func: ?fnType = null,                            // function to execute the option
    short: Byte,                                    // short form, e.g., -n|-N
    long: Slice,                                    // long form, e.g., --name
    value: Slice = "",                              // value of the option
    const fnType = *const fn(Slice) bool;
};

pub const Error = error {
    NoArgsProvided,
    UnknownCommand,
    UnknownOption,
    MissingRequiredOption,
    UnexpectedArgument,
    CommandExecutionFailed,
    TooManyCommands,
    TooManyOptions,
};
