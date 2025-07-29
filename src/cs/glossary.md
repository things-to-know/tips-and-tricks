# Computer Science (CS) / Glossary

## Terms

### Algorithm \[Computer science\]

TODO

https://en.wikipedia.org/wiki/Algorithm

> In mathematics and computer science, an algorithm is a finite sequence of mathematically rigorous
  instructions, typically used to solve a class of specific problems or to perform a computation.

### Algorithms suite \[Cryptography\]

A set of one or more [cryptographic algorithms](#cryptographic-algorithm), often used together
to provide a security service, such as digital signatures.

### Associative array \[Computer science\]

Aka "dictionary", [map](#map-noun-computer-science).

An _abstract_ [data type](#data-type-computer-science) that [maps](#map-verb-computer-science)
_keys_ to values.

### Cipher \[Cryptography\]

TODO

See [Encryption](#encryption-cryptography), [Decryption](#decryption-cryptography),
[Encryption algorithm](#encryption-algorithm-cryptography).

### Ciphertext \[Cryptography\]

Aka "encrypted information", "encoded information" (but technically different from).

[Wikipedia](https://en.wikipedia.org/wiki/Ciphertext):

> [...] the result of [encryption](#encryption-cryptography) performed on
  [plaintext](#plaintext-cryptography) using an [algorithm](#cryptographic-algorithm),
  called a [cipher](#cipher-cryptography).

It is:

> [...] also known as encrypted or encoded information because it contains a form of the
  original [plaintext](#plaintext-cryptography) that is unreadable by a human or computer
  without the proper [cipher](#cipher-cryptography) to [decrypt](#decryption-cryptography) it.

Warning: don't confuse with _codetext_, which is the result of a _code_, not a
[cipher](#cipher-cryptography).

See [Encryption](#encryption-cryptography), [Decryption](#decryption-cryptography),
[Encryption algorithm](#encryption-algorithm-cryptography).

### Code \[Computer science\]

In computer science, a _code_ is \[[Wikipedia](https://en.wikipedia.org/wiki/Code)\]:

> [...] an [algorithm](#algorithm-computer-science) that uniquely represents _symbols_ from some
  _source alphabet_, by _encoded strings_, which may be in some other _target alphabet_.
> An extension of the code for representing sequences of symbols over the source alphabet
  is obtained by concatenating the encoded strings.

### Code symbol \[Computer science\]

TODO

### Computation \[Computer science\]

[Wikipedia](https://en.wikipedia.org/wiki/Computation):

> A computation is any type of arithmetic or non-arithmetic calculation that is "well-defined".
> Common examples of computation are _mathematical equation solving_ and the execution of
  [computer algorithms](#algorithm-computer-science).

_Computer science_ is an academic field that involves the study of _computation_.

See [Model of computation](#model-of-computation-computer-science).

### Computer system

TODO

### Cryptographic algorithm

TODO

### Cryptographic application

TODO

### Cryptographic hash

TODO

### Cryptographic hash function (CHF)

Wikipedia:

> [...] a [hash algorithm](#hash-algorithm) that has special properties desirable for a
  [cryptographic application](#cryptographic-application):
>
> - the probability of a particular n-bit output result ([hash value](#hash-value)) for a
>   random input string ("message") is 2^{-n} (as for any good hash), so the hash value
>   can be used as a representative of the message;
> - finding an input string that matches a given hash value (a pre-image) is _infeasible_,
>   _assuming all input strings are equally likely_.
>   The _resistance_ to such search is quantified as _security strength_: a
>   [cryptographic hash](#cryptographic-hash) with `n` bits of hash value is expected to have a preimage resistance strength of
n
{\displaystyle n} bits, unless the space of possible input values is significantly smaller than
2
n
{\displaystyle 2^{n}} (a practical example can be found in § Attacks on hashed passwords);
a second preimage resistance strength, with the same expectations, refers to a similar problem of finding a second message that matches the given hash value when one message is already known;
finding any pair of different messages that yield the same hash value (a collision) is also infeasible: a cryptographic hash is expected to have a collision resistance strength of
n
/
2
{\displaystyle n/2} bits (lower due to the birthday paradox).

### Cryptography

The discipline that embodies principles, means and methods for the
[transformation of data](#data-transformation-computer-science) to:

- hide its information content,
- prevent its undetected modification, and/or
- prevent its unauthorized use

### Data structure \[Computer science\]

TODO

### Data tampering \[Computer science\]

An intentional but unauthorized act resulting in the modification of a system, its components,
its intended behavior, or data.

[Digital signatures](#digital-signature) are used to detect if data has been tampered with
after being signed.

### Data transformation \[Computer science\]

TODO

### Data type \[Computer science\]

TODO

### Decryption \[Cryptography\]

It is the inverse of [encryption](#encryption-cryptography).

[Wikipedia](https://en.wikipedia.org/wiki/Encryption):

> [...] is the process of turning [ciphertext](#ciphertext-cryptography) into readable
  [plaintext](#plaintext-cryptography).

See [Encryption](#encryption-cryptography),
[Encryption algorithm](#encryption-algorithm-cryptography), [Cipher](#cipher-cryptography).

### Decoding

The reverse of [encoding](#encoding).

The process of converting [code symbols](#code-symbol-computer-science) back into a form
that the recipient understands.

### Encoding

The reverse of [decoding](#decoding)

The process of converting information from a source into
[code symbols](#code-symbol-computer-science) for communication or storage.

### Encryption \[Cryptography\]

It is the inverse of [decryption](#decryption-cryptography).

[Wikipedia](https://en.wikipedia.org/wiki/Encryption):

> [...] the process of transforming information in a way that, ideally, only authorized parties
  can ~~decode~~ \[decrypt\].
> This process converts the original representation of the information, known as
  [plaintext](#plaintext-cryptography), into an alternative form known as
  [ciphertext](#ciphertext-cryptography).
> Despite its goal, encryption does not itself prevent _interference_ but denies the
  intelligible content to a would-be _interceptor_.

See [Decryption](#decryption-cryptography),
[Encryption algorithm](#encryption-algorithm-cryptography), [Cipher](#cipher-cryptography).

### Encryption algorithm \[Cryptography\]

TODO

### Digital signature

Aka "signature".

A string of bits computed from data and a [private key](#private-key-cryptography).
It allows a recipient, using the corresponding public key, to [verify the origin](#proof-of-origin-computer-science)
and [integrity](#proof-of-integrity-computer-science) of the data.

Digital signatures are a type of [public-key cryptography](#public-key-cryptography), and are
commonly used for _software distribution_, financial transactions, legal contracts,
and in other cases where it is important to detect forgery or [tampering](#data-tampering-computer-science).

[Wikipedia](https://en.wikipedia.org/wiki/Digital_signature):

> A mathematical scheme for verifying the authenticity of digital messages or documents.
  A valid digital signature on a message gives a recipient confidence that the message
  came from a sender known to the recipient.
> [...] a digital signature on a message is mathematically bound to the content of the message
  so that it is infeasible for anyone to forge a valid digital signature on any other message.

### Digital signature scheme

A digital signature scheme typically consists of three algorithms:

- A [key generation algorithm](#key-generation-algorithm-cryptography)
- A [signing algorithm](#signing-algorithm-digital-signature)
- A [signature verification algorithm](#signature-verification-algorithm)

### Digital Signature Algorithm (DSA)

The original [cryptographic algorithm](#cryptographic-algorithm) for generating digital signatures,
that, as of FIPS 186-5, is no longer approved for generating new signatures, but can be used
to verify signatures created before the standard's implementation date.

### Federal Information Processing Standards (FIPS)

The official series of publications relating to standards and guidelines adopted by NIST
for use in non-military U.S. federal government computer systems.

### Hash (noun) \[Computer science\]

A synonym of [hash value](#hash-value) (use the latter for clarity).

### Hash (verb) \[Computer science\]

TODO

### Hash algorithm

A [map](#map-noun-computer-science) of an arbitrary binary string to a binary string with
a fixed size of `n` bits.

### Hash code

TODO

### Hash function

TODO:
- is it a strict synonym of [hash algorithm](#hash-algorithm)?
- must it be a [one-way function](#one-way-function-computer-science)?

Wikipedia:

> [...] any [function](#function-computer-science) that can be used to
  [map](#map-verb-computer-science) data of arbitrary size to fixed-size values, though there are
  some hash functions that support _variable-length output_.
> The values returned by a hash function are called [hash values](#hash-value) [...].
  The values are usually used to _index_ a fixed-size table called a [hash table](#hash-table).
> Use of a hash function to index a hash table is called _hashing_ or _scatter-storage addressing_.

### Hash map

A [map](#map-noun-computer-science) implemented by a [hash table](#hash-table).

### Hash table

[Wikipedia](https://en.wikipedia.org/wiki/Hash_table):

> [...] a [data structure](#data-structure-computer-science) that implements an
  [associative array](#associative-array-computer-science) [...].
> A hash table uses a [hash function](#hash-function) to _compute_ an _index_, also called a
  [hash code](#hash-code), into an array of _buckets_ or _slots_, from which the desired value
  can be found. During _lookup_, the _key_ is [hashed](#hash-verb-computer-science),
  and the resulting [hash](#hash-value) indicates where the corresponding value is stored.

### Hash value

Aka "hash code", "hash digest", "message digest", [hash](#hash-noun-computer-science).

The value returned by a [hash function](#hash-function).

### Identity \[Computer science\]

TODO:

- define?
- same as [subject identity](#subject-identity-computer-science)?

### Identity authentication \[Computer science\]

The process of verifying the [identity of a subject](#subject-identity-computer-science)
(e.g. a user, device or process) to a system.

A [digital signature](#digital-signature) authenticates the identity of the
[signatory](#signatory-digital-signature).

### Index (noun) \[Computer science\]

TODO

### Key \[Cryptography\]

In cryptography, by key we usually mean a "private key" or "secret key", and it is:

> [...] is a piece of information, usually a string of numbers or letters that are stored
  in a file, which, when processed through a [cryptographic algorithm](#cryptographic-algorithm),
  can encode or decode cryptographic data.
> Based on the used method, the key can be different sizes and varieties, but in all cases,
  the strength of the encryption relies on the security of the key being maintained.
  A key's security strength is dependent on its algorithm, the size of the key,
  the [generation of the key](#key-generation-algorithm-cryptography), and the process of key exchange.

### Key generation algorithm \[Cryptography\]

An "algorithm that selects a [private key](#private-key-cryptography) uniformly at random from
a set of possible private keys".

In [public-key (asymmetric) cryptography](#public-key-cryptography), it generates a
[keypair](#keypair-cryptography).

See [Digital signature scheme](#digital-signature-scheme).

### Key generator \[Cryptography\]

Aka "keygen".

A device or program used to generate keys using a
[key generation algorithm](#key-generation-algorithm-cryptography).

### Keypair \[Cryptography\]

In cryptography, a keypair is a mathematically linked pair of keys used in
[public-key (asymmetric) cryptography](#public-key-cryptography).

- a [public key](#public-key-cryptography) (which may be widely distributed), and
- a [private key](#private-key-cryptography) (which is kept secret).

### Map (noun) \[Computer science\]

TODO

### Map (verb) \[Computer science\]

TODO

### Model of computation \[Computer science\]

In computer science, a model of computation is a mathematical abstraction, it is a model
\[[Wikipedia](https://en.wikipedia.org/wiki/Model_of_computation)\]:

> [...] which describes how an output of a _mathematical function_ is
  [computed](#computation-computer-science) given an input.
  [...] it describes how _units of computations_, _memories_ and _communications_ are organized.
>
> The _computational complexity_ of an [algorithm](#algorithm-computer-science) can be measured
  given a model of computation. Using a model allows studying the performance of algorithms
  independently of the _variations_ that are specific to particular _implementations_ and
  specific technology.

Categories of models of computation:

- _Sequential models_ (or _state models_):
  e.g. _Finite-state machine_, _Turing machine_, _Random-access machine_
- _Functional models_:
  e.g. _Abstract rewriting systems_, _Lambda calculus_
- _Concurrent models_: e.g. _Actor model_, _Cellular automaton_, _Petri nets_

### National Institute of Standards and Technology (NIST)

TODO

### Non-repudiation assurance \[Cryptography\]

Assurance that a [signatory](#signatory-digital-signature) can't later deny having performed
an action such as [signing a document](#digital-signature).
This provides [proof of origin](#proof-of-origin-computer-science) and [integrity](#proof-of-integrity-computer-science)
[verifiable by a third party](#third-party-verification-cryptography).

### One-way function \[Computer science\]

Simple definition: in computer science, a one-way function is a [function](#fun) that is "easy" to compute
in one direction, but "hard" to reverse.

[Wikipedia](https://en.wikipedia.org/wiki/One-way_function):

> [...] a function that is easy to compute on every input, but hard to invert given the image
  of a random input.
> Here, "easy" and "hard" are to be understood in the sense of computational complexity theory,
  specifically the theory of polynomial time problems.

### Plaintext \[Cryptography\]

[Wikipedia](https://en.wikipedia.org/wiki/Plaintext):

> [...] unencrypted information pending input into
  [cryptographic algorithms](#cryptographic-algorithm), usually
  [encryption algorithms](#encryption-algorithm-cryptography).

It:

> [...] usually refers to data that is transmitted or stored unencrypted.

See [Encryption](#encryption-cryptography), [Decryption](#decryption-cryptography),
[Encryption algorithm](#encryption-algorithm-cryptography), [Cipher](#cipher-cryptography).

### Private-key \[Cryptography\]

TODO

### Proof of integrity \[Computer science\]

TODO

### Proof of origin \[Computer science\]

TODO

### Pseudorandom number generator (PRNG)

TODO: see <https://en.wikipedia.org/wiki/Pseudorandom_number_generator>,
<https://en.wikipedia.org/wiki/Pseudorandom_generator>

### Public-key \[Cryptography\]

TODO

### Public-key cryptography

Aka "asymmetric cryptography".

A form of [cryptography](#cryptography) that uses a pair of keys
([keypair](#keypair-cryptography)).

For digital signatures:

- the [private key](#private-key-cryptography) is used to sign, and
- the public key is used to verify.

### Secure communication \[Computer science\]

TODO

### Shared secret \[Cryptography\]

TODO: see <https://en.wikipedia.org/wiki/Shared_secret>

### Signing algorithm \[Digital signature\]

A "[cryptographic algorithm](#cryptographic-algorithm) that, given a message and a
[private key](#private-key-cryptography), produces a" [digital signature](#digital-signature).

See [Digital signature scheme](#digital-signature-scheme).

### Signature verification algorithm

An "[algorithm](#algorithm-computer-science) that, given the message, [public key](#public-key-)
and [signature](#digital-signature), either accepts or rejects the message's _claim_
to _authenticity_."

See [Digital signature scheme](#digital-signature-scheme).

### Signatory \[Digital signature\]

The entity that uses a [private key](#private-key-cryptography) to generate a
[digital signature](#digital-signature) on data.

### Signature repudiation \[Digital signature\]

TODO: verify this whole item, including the term itself.

The act of falsely denying having generated a signature.

The [non-repudiation](#non-repudiation-assurance-cryptography) service provided
by DSS is designed to prevent this.

### Signature verification \[Digital signature\]

TODO

### Signed data \[Digital signature\]

TODO: verify; check synonyms

Data to which a [digital signature](#digital-signature) has been applied.
The digital signature is provided to the _verifier_ along with this data.

### Subject identity \[Computer science\]

TODO

### Third-party verification \[Cryptography\]

TODO
