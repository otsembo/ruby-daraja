# Development

## 0.1.0-pre-alpha / 2023-04-18
### Initial release

This release is a pre-alpha release and is not intended for production use. It is intended to allow early adopters to try out the new features and provide feedback. Some features are not yet implemented or are not fully functional. Please see the [Known Issues](#known-issues) section for more details.
### Added
- Added initial support for initiate STK push requests for both _**C2B**_ and **_B2C_** transactions on `PayBill` and `BuyGoods` shortcodes.
- Added sample documentation for the new features in GitHub Readme.
- Add support for authorization using `Consumer Secret` and `Consumer Key` for both _**C2B**_ and **_B2C_** transactions.


## Known Issues
- Full support for status query requests is not yet implemented.
- B2C requests are flaky and may fail due to `OpenSSL` errors.
- The library is not yet fully tested and may contain bugs.