# Specification, Standards and Formats / SSH (Secure Shell) Protocol

> The Secure Shell (SSH) Protocol is a protocol for secure remote login and other secure
  network services over an insecure network.

Source: [RFC 4251](https://datatracker.ietf.org/doc/html/rfc4251).

## FAQ

- Is `ssh-rsa` a public key algorithm?
  - Yes, it is the name of a [public key algorithm](#public-key-algorithm) used in the SSH protocol
    for authenticating a client or server
- Is `ssh-rsa` a key type, a key format or a public key algorithm?
- Is `ssh-rsa` a key type or a public key algorithm?
  - It is a _key type_ that uses the _RSA_ public key algorithm.
    The _key type_ is a string that identifies the type of public key or certificate.

## Architecture

"The SSH protocol consists of three major components":

- [SSH Transport Layer Protocol](#SSH-Transport-Layer-Protocol)
- [User Authentication Protocol](#User-Authentication-Protocol)
- [Connection Protocol](#Connection-Protocol)

Flow:

1. A secure transport layer connection is established
2. The client sends a service request
3. A second service request is sent after user authentication is complete

Source: [RFC 4251](https://datatracker.ietf.org/doc/html/rfc4251).

> This allows new protocols to be defined and coexist with the protocols listed above.

### Components

#### SSH Transport Layer Protocol

References: RFC 4251, RFC 4253

It:

- "provides strong encryption, server authentication, and integrity protection"
- "can be used as a basis for a number of secure network services"
- "typically runs on top of TCP/IP"
  ("but might also be used on top of any other reliable data stream")
- "may also provide compression"

The following are all negotiated:

- key exchange method
- public key algorithm
- symmetric encryption algorithm
- message authentication algorithm
- hash algorithm

#### User Authentication Protocol

> The User Authentication Protocol authenticates the client-side user to the server.
> It runs over the transport layer protocol.

#### Connection Protocol

> The Connection Protocol multiplexes the encrypted tunnel into several logical channels.
> It runs over the user authentication protocol.
>
> The connection protocol provides channels that can be used for a wide range of purposes.
  Standard methods are provided for setting up secure interactive shell sessions and for
  forwarding ("tunneling") arbitrary TCP/IP ports and X11 connections.

## Technical glossary

### Key exchange (KEX)

#### Server host key

1. "Each server host SHOULD have a host key"
2. "Hosts MAY have multiple host keys using multiple different algorithms"
3. "Multiple hosts MAY share the same host key"

> The _server host key_ is used during _key exchange_ \[(KEX)\] to verify that the client
  is really talking to the correct server.

The SSH protocol uses a _key exchange_ (KEX) algorithm to establish a _shared secret_ between the
client and server.

#### Process

- "begins by each side sending name-lists of supported algorithms"
  - "each side has a _preferred algorithm_ in each category, and it is assumed that
    most implementations, at any given time, will use the same preferred algorithm"
- "each side MAY guess which algorithm the other side is using, and MAY send an initial
  _key exchange packet_ according to the algorithm" ("if appropriate for the preferred method")

Output: two values are produced:

- a _shared secret_ `K`
- an _exchange hash_ `H`:
  - "additionally used as the _session identifier_" ("a unique identifier for this connection")
    It is used by authentication methods as a part of the data that is signed as a proof of possession of a
   private key.  Once computed, the session identifier is not changed,
   even if keys are later re-exchanged."

Derived values:

- [encryption key](#Encryption-key): derived from  `K` and `H`
- [authentication key](#Authentication-key): derived from `K` and `H`
- [session identifier](#Session-identifier-of-a-connection):
  equal to `H` (from the first _key exchange_)

> Each [key exchange method](#key-exchange-method) specifies a [hash function](#hash-function)
  that is used in the key exchange. The same hash algorithm MUST be used in _key derivation_.
  Here, we'll call it HASH.

#### Trust models

> The client ~~must~~ \[should\] have a priori knowledge of the server's public host key.

Trust models for the _server name_ - _host key_ association:

1. Client local database of name-to-key associations:
   "the client has a local database that associates each host name (as typed by the user)
   with the corresponding public host key"
   - advantages: "requires no centrally administered infrastructure, and no third-party coordination"
   - disadvantages: "the database of name-to-key associations may become burdensome to maintain"
2. Client trusted CA:
   "The host name-to-key association is certified by a trusted certification authority (CA)"
   - advantages: "the client only knows the CA root key, and can verify the validity of all
     host keys certified by accepted CAs"; ideally a single CA root key is sufficient
   - disadvantages: "each host key must be appropriately certified by a central authority before
     authorization is possible"; "a lot of trust is placed on the central infrastructure"

It is not mandatory the client checks _server name_ - _host key_ association, and

> the connection still provides protection against _passive listening_; however, it becomes
> **vulnerable** to active _man-in-the-middle attacks_.

### Exchange Hash (value)

Warning: according to the RFC, _exchange hash_ `H` is the resulting value.
However, people often use the term _exchange hash_ to refer to the _hash function_ that creates `H`.

The _exchange hash_ is a hash of the following data:
- the _session identifier_ (a unique identifier for this connection)
- the _server host key_ (the public key of the server)
- the _client host key_ (the public key of the client)
- the _key exchange method_ (the name of the key exchange method used)
- the _hash function_ (the name of the hash function used)
- the _hash algorithm_ (the name of the hash algorithm used for computing the exchange hash)
- the _encryption key_ (the key used for encrypting the data)
- the _authentication key_ (the key used for authenticating the data)
- any additional data that is needed for the key exchange

### Public Key Algorithm

"This protocol has been designed to operate with almost any":

- _public key format_
- _encoding_
- _algorithm_ (_signature_ and/or _encryption_)

#### Key type

> The _key type_ is a string that identifies the type of _public key_ or _certificate_.

It is the underlying _cryptographic algorithm_ being used thus it defines the
mathematical principles of the key.

Examples:

- `ssh-rsa`: RSA (Rivest-Shamir-Adleman)
- `ssh-dss` (obsolete and insecure): the _Digital Signature Standard_ (DSS)
  - it uses the _Digital Signature Algorithm_ (DSA) for creating digital signatures

#### Public key type

Defined by:

- _Key format_: "how is the key encoded and how certificates are represented"
  - "The key blobs in this protocol MAY contain certificates in addition to keys."
- _Signature_ and/or _encryption_ algorithms:
  - "Some key types may not support both signing and encryption."
  - "Key usage may also be restricted by policy statements (e.g., in certificates)."
  - "In this case, different key types SHOULD be defined for the different policy alternatives."
- Encoding of signatures and/or encrypted data:
  - This includes but is not limited to _padding_, _byte order_, and _data formats_.

The following public key and/or certificate formats are currently defined:

   ssh-dss           REQUIRED     sign   Raw DSS Key
   ssh-rsa           RECOMMENDED  sign   Raw RSA Key
   pgp-sign-rsa      OPTIONAL     sign   OpenPGP certificates (RSA key)
   pgp-sign-dss      OPTIONAL     sign   OpenPGP certificates (DSS key)

Additional _key types_ may be defined, as specified in RFC 4251 and in RFC 4250.

The _key type_ MUST always be explicitly known (from _algorithm negotiation_ or some other source).
It is not normally included in the _key blob_.

Certificates and public keys are encoded as follows:

      string    certificate or public key format identifier
      byte[n]   key/certificate data

- The certificate part may be a zero length string, but a public key is required.
  - This is the public key that will be used for authentication.
  - The certificate sequence contained in the certificate blob can be used to provide authorization.
- Public key/certificate formats that do not explicitly specify a signature format identifier MUST use the public key/certificate format identifier as the signature identifier.

     Signatures are encoded as follows:

        string    signature format identifier (as specified by the
                  public key/certificate format)
        byte[n]   signature blob in format specific encoding.

     The "ssh-dss" key format has the following specific encoding:

        string    "ssh-dss"
        mpint     p
        mpint     q
        mpint     g
        mpint     y

     Here, the 'p', 'q', 'g', and 'y' parameters form the signature key
     blob.

     Signing and verifying using this key format is done according to the Digital Signature Standard [FIPS-186-2] using the SHA-1 hash [FIPS-180-2].

     The resulting signature is encoded as follows:

        string    "ssh-dss"
        string    dss_signature_blob

     The value for `dss_signature_blob` is encoded as a string containing `r`, followed by `s` (which are 160-bit integers, without lengths or padding, unsigned, and in _network byte order_).

     The `ssh-rsa` key format has the following specific encoding:

        string    "ssh-rsa"
        mpint     e
        mpint     n

     Here the `e` and `n` parameters form the _signature key blob_.

     Signing and verifying using this key format is performed according to the RSASSA-PKCS1-v1_5 scheme in [RFC3447] using the SHA-1 hash.

     The resulting signature is encoded as follows:

        string    "ssh-rsa"
        string    rsa_signature_blob

     The value for `rsa_signature_blob` is encoded as a string containing `s` (which is an integer, without lengths or padding, unsigned, and in _network byte order_).

     The `pgp-sign-rsa` method indicates the certificates, the public key, and the signature are in OpenPGP compatible binary format ([RFC2440]).
     This method indicates that the key is an RSA-key.

     The "pgp-sign-dss" is as above, but indicates that the key is a
     DSS-key.

### Key Exchange Method

TODO

> The _key exchange method_ specifies how one-time _session keys_ are generated for encryption
> and for authentication, and how the _server authentication_ is done.

For example:

- `diffie-hellman-group1-sha1`: (obsolete, insecure) defined in RFC 4253

### Hash function

See [Hash function](#hash-function).

For example:

- `SHA-1`: **warning**, cryptographically broken since 2017
- `SHA-256`: member of the secure SHA-2 family of hash functions

### Hash algorithm (Hash function) for computing the exchange hash

Aka _hashing algorithm_.

The _hash algorithm_ for computing the exchange hash is defined by the method name, and is called HASH.

Note: sometimes the term _hash algorithm_ is used instead of _hash function_,
and it is also referred to, in the RFC, as `HASH`.

For example:

- `diffie-hellman-group1-sha1` (obsolete, insecure):
  - key generation: `Diffie-Hellman` with the predefined mathematical _Group 1_
  - hash function: `SHA-1` (cryptographically broken since 2017)
- `curve25519-sha256`:
  - key generation: `Curve25519` elliptic curve
  - hash function: `SHA-256`
- `diffie-hellman-group18-sha512`

### Session identifier of a connection

The _session identifier_ is a unique identifier for a connection.

> It is used by _authentication methods_ as a part of the data that is signed as a
  _proof of possession_ of a _private key_.
> Once computed, the _session identifier_ is not changed, even if keys are later re-exchanged.

### Encryption key

TODO

### Authentication key

TODO

### Server host key

TODO

### Public key format

Note: the definitions of _public key format_ inferred from the RFCs aren't very clear.
RFC 8332 provides some clarification.

It can refer to:

1. "procedures used to generate and validate a private/public keypair"
2. "a format used to encode a public key"

procedures used to generate and validate a private/public
       keypair;
   B.  a format used to encode a public key

### Signature scheme

The specific combination of a _public key algorithm_ (e.g. RSA) and a _hash function_ (e.g. SHA-256)
used to create a _digital signature_.


## RFCs

- IANA assigned numbers to the protocol:
  [RFC 4250](https://datatracker.ietf.org/doc/html/rfc4250):
  "The Secure Shell (SSH) Protocol Assigned Numbers"
- Protocol Architecture:
  [RFC 4251](https://datatracker.ietf.org/doc/html/rfc4251):
  "The Secure Shell (SSH) Protocol Architecture"
- [RFC 4252](https://datatracker.ietf.org/doc/html/rfc4252):
  "The Secure Shell (SSH) Authentication Protocol"
- [RFC 4253](https://datatracker.ietf.org/doc/html/rfc4253):
  "The Secure Shell (SSH) Transport Layer Protocol"
- [RFC 4254](https://datatracker.ietf.org/doc/html/rfc4254):
  "The Secure Shell (SSH) Connection Protocol"
- [RFC 4255](https://datatracker.ietf.org/doc/html/rfc4255):
  "Using DNS to Securely Publish Secure Shell (SSH) Key Fingerprints"
- [RFC 4256](https://datatracker.ietf.org/doc/html/rfc4256):
  "Generic Message Exchange Authentication for the Secure Shell Protocol (SSH)"

### Related RFCs

- [6668](https://datatracker.ietf.org/doc/html/rfc6668):
  "SHA-2 Data Integrity Verification for the Secure Shell (SSH) Transport Layer Protocol"
  (updates RFC 4253)
- [RFC 8268](https://datatracker.ietf.org/doc/html/rfc8268)
  "More Modular Exponentiation (MODP) Diffie-Hellman (DH) Key Exchange (KEX) Groups for
  Secure Shell (SSH)"
  (updates RFC 4250, RFC 4253)
- [RFC 8308](https://datatracker.ietf.org/doc/html/rfc8308)
  "Extension Negotiation in the Secure Shell (SSH) Protocol"
  (updates RFC 4254, RFC 4252, RFC 4253, RFC 4251)
- [RFC 8332](https://datatracker.ietf.org/doc/html/rfc8332)
  "Use of RSA Keys with SHA-256 and SHA-512 in the Secure Shell (SSH) Protocol"
  (updates RFC 4253, RFC 4252)
- [RFC 8709](https://datatracker.ietf.org/doc/html/rfc8709)
  "Ed25519 and Ed448 Public Key Algorithms for the Secure Shell (SSH) Protocol"
  (updates RFC 4253)
- [RFC 8758](https://datatracker.ietf.org/doc/html/rfc8758)
  "Deprecating RC4 in Secure Shell (SSH)"
  (updates RFC 4253)
- [RFC 9141](https://datatracker.ietf.org/doc/html/rfc9141)
  "Updating References to the IETF FTP Service"
  (updates RFC 3295, RFC 4547, RFC 5098, RFC 4546, RFC 3020, RFC 7241, RFC 2955, RFC 2954,
  RFC 6756, RFC 4131, RFC 4036, RFC 3684, RFC 3201, RFC 2648, RFC 2418, RFC 4323, RFC 3202,
  RFC 3962, RFC 4251, RFC 4682, RFC 4639, RFC 3970, RFC 3083, RFC 2077, RFC 5428)
- [RFC 9142](https://datatracker.ietf.org/doc/html/rfc9142)
  "Key Exchange (KEX) Method Updates and Recommendations for Secure Shell (SSH)"
  (updates RFC 4432, RFC 4253, RFC 4462, RFC 4250)
- [RFC 9519](https://datatracker.ietf.org/doc/html/rfc9519)
  "Update to the IANA SSH Protocol Parameters Registry Requirements"
  (updates RFC 4250, RFC 4716, RFC 4819, RFC 8308)
