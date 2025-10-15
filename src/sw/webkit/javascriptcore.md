# Software / WebKit / JavaScriptCore

The built-in JavaScript engine for WebKit.

- Homepage: N/A
- Code repo: same as WebKit
- Documentation:
  - WebKit docs: <https://docs.webkit.org/Deep%20Dive/JSC/JavaScriptCore.html>
  - Apple Developer Documentation / JavaScriptCore:
    <https://developer.apple.com/documentation/javascriptcore>
  - WebKit GTK docs: <https://webkitgtk.org/reference/jsc-glib/stable/>

> Implements ECMAScript as in ECMA-262 specification.
>
> It consists of the following building blocks:
  lexer, parser, start-up interpreter (LLInt), baseline JIT, a low-latency optimizing JIT (DFG),
  and a high-throughput optimizing JIT (FTL).
>
> JavaScriptCore is often referred with different names, such as _SquirrelFish_ and
  _SquirrelFish Extreme_.
  Within the context of Safari, _Nitro_ and _Nitro Extreme_ (the marketing terms from Apple) are
  also commonly used. However, the name of the project and the library is always JavaScriptCore.

Features:

- "Evaluate JavaScript programs from within Swift, Objective-C, and C-based apps"
- "Support JavaScript scripting of your app": "insert custom objects into the JavaScript environment"
