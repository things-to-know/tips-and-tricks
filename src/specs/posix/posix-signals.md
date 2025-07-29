# POSIX Signals

<https://en.wikipedia.org/wiki/Signal_(IPC)#POSIX_signals>

What is a signal (in the UNIX world)?

> A signal is an _asynchronous_ _notification_ sent to a _process_ or to a specific
> _thread_ within the same process to notify it of an _event_.
> Common uses of signals are to _interrupt_, _suspend_, _terminate_ or _kill_ a _process_.

## Signal Handling

A:

> A process can define how to handle incoming POSIX signals.
> If a process does not define a behaviour for a signal, then the _default handler_ for that
> signal is being used.

B:

> If a _signal handler_ is not installed for a particular signal, the _default handler_ is used.
  Otherwise, the signal is _intercepted_, and the _signal handler_ is invoked.
> The process can also specify two default behaviors, without creating a handler:
> - ignore the signal (`SIG_IGN`)
> - use the default signal handler (`SIG_DFL`).
>
> There are two signals which cannot be intercepted and handled: `SIGKILL` and `SIGSTOP`.

### Issues

> Signal handling is vulnerable to _race conditions_.
> As signals are _asynchronous_, another signal (even of the same type) can be delivered to the
> process during execution of the _signal handling routine_.

## Signal Types

### Default Actions

- **Ignore**: The signal is ignored.
- **Terminate**: The process is terminated.
- **Core Dump**: A core dump file is created and the process is terminated.
- **Stop**: The process is stopped and can be resumed later.

### Signal Handling

- **Signal Handlers**: Custom functions that define how a process should respond to a specific signal.
- **Reset to Default**: Restore the default action for a signal.

### Signal Masking

- **Block Signals**: Temporarily prevent a signal from being delivered to a process.
- **Unblock Signals**: Allow a blocked signal to be delivered.

## Common POSIX Signals

| Signal    | Description                                    |
|-----------|------------------------------------------------|
| `SIGINT`  | Interrupt signal (Ctrl+C)                      |
| `SIGKILL` | Terminate signal (cannot be caught or ignored) |
| `SIGTERM` | Termination request                            |
| `SIGSTOP` | Stop signal (cannot be caught or ignored)      |
| `SIGCONT` | Continue signal                                |

## References

<https://en.wikipedia.org/wiki/Signal_(IPC)#POSIX_signals>
