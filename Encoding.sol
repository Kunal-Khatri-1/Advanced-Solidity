// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Encoding {
    function combineStrings() public pure returns (string memory) {
        // abi.encodePacked returns bytes object
        // encoding "Hello Mom!" and "miss you!" together into their bytes form
        // then typecasting the bytes into string
        return string(abi.encodePacked("Hello Mom! ", "miss you!"));
    }

    // 0.8.12+
    // string.concat("stringA", "stringB");

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    // encodeStringBytes and encodeStringPacked give the same compresed output while encodeString gives output in long form
    // SEE THE DIFFERENCE BETWEEN bytes("some string") and abi.encodePacked("some string")
    function encodeString() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string");
        return someString;
    }

    // abi.encode => encode normally(all the 0s are not ignored)
    // abi.encodePacked => packed encoding (help save gas)

    function encodeStringPacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("some string");
    }

    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("some string");
        return someString;
    }

    function decodeString() public pure returns (string memory) {
        // abi.decode(<encoded data>, <types to decode into>)
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }

    function multiEncode() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string ", "It's bigger");
        return someString;
    }

    function multiDecode() public pure returns (string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(
            multiEncode(),
            (string, string)
        );

        return (someString, someOtherString);
    }

    // cannot decode encodePacked
    function multiEncodePacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked(
            "some string ",
            "it's bigger"
        );
    }

    // This Doesn't work
    function multiDecodePacked() public pure returns (string memory) {
        string memory someString = abi.decode(multiEncodePacked(), (string));
        return someString;
    }

    // However, this does work
    function multiStringCastPacked() public pure returns (string memory) {
        string memory someString = string(multiEncodePacked());
        return someString;
    }
}
