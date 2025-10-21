"""faulthandler module."""

import sys
from _typeshed import FileDescriptorLike

def cancel_dump_traceback_later() -> None:
    """
    cancel_dump_traceback_later():
    cancel the previous call to dump_traceback_later().
    """
    ...
def disable() -> None:
    """disable(): disable the fault handler"""
    ...
def dump_traceback(file: FileDescriptorLike = ..., all_threads: bool = ...) -> None:
    """dump_traceback(file=sys.stderr, all_threads=True): dump the traceback of the current thread, or of all threads if all_threads is True, into file"""
    ...

if sys.version_info >= (3, 14):
    def dump_c_stack(file: FileDescriptorLike = ...) -> None: ...

def dump_traceback_later(timeout: float, repeat: bool = ..., file: FileDescriptorLike = ..., exit: bool = ...) -> None:
    """
    dump_traceback_later(timeout, repeat=False, file=sys.stderr, exit=False):
    dump the traceback of all threads in timeout seconds,
    or each timeout seconds if repeat is True. If exit is True, call _exit(1) which is not safe.
    """
    ...
def enable(file: FileDescriptorLike = ..., all_threads: bool = ...) -> None:
    """enable(file=sys.stderr, all_threads=True): enable the fault handler"""
    ...
def is_enabled() -> bool:
    """is_enabled()->bool: check if the handler is enabled"""
    ...

if sys.platform != "win32":
    def register(signum: int, file: FileDescriptorLike = ..., all_threads: bool = ..., chain: bool = ...) -> None:
        """register(signum, file=sys.stderr, all_threads=True, chain=False): register a handler for the signal 'signum': dump the traceback of the current thread, or of all threads if all_threads is True, into file"""
        ...
    def unregister(signum: int, /) -> None:
        """unregister(signum): unregister the handler of the signal 'signum' registered by register()"""
        ...
