const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    // UNCOMMENT FOR LIB BUILD
    //const lib = b.addStaticLibrary("bjrpc", null);
    //lib.setTarget(target);
    //lib.setBuildMode(mode);
    //lib.linkLibC();
    //lib.force_pic = true;

    const server = b.addExecutable("bjrpc-server", null);
    server.setTarget(target);
    server.setBuildMode(mode);
    server.install();
    server.linkLibC();
    //server.linkLibrary("lib/"); // link bjrpc lib
    server.addCSourceFiles(&.{
        "src/main.c",
    }, &.{"-Wall"});
}
