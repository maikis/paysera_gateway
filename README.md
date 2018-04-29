# PayseraGateway
PayseraGateway is [Paysera](https://www.paysera.lt/v2/en-LT/index) integration gem, designed to help
Ruby app developers to integrate `Paysera` payments in easy and quick way. The gem is planned to be
a substitute for [Paysera Payment Gateway](https://developers.paysera.com/en/payments/current),
precisely [WebToPay](https://bitbucket.org/paysera/libwebtopay/raw/default/WebToPay.php) library.

**Please note that this library is not yet finished and tested in the production **

## DISCLAIMER

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'paysera_gateway'
```

And then execute:
```bash
$ bundle
```

## Usage

Use the gateway by calling `paysera_payment_path` with request parameters from the Paysera parameter list (see [Integration with a library](https://developers.paysera.com/en/payments/current#integration-via-library) for full parameter list).

Example:

```Ruby
params = {
  projectid: 1111,
  orderid: 22,
  accepturl: 'http://www.test.org/accept',
  cancelurl: 'http://www.test.org/cancel',
  callbackurl: 'http://www.test.org/callback',
  sign_password: '1234abcd',
  test: 1
}
```

You can add form on your page to gather the required params and send it to the `paysera_gateway` controller. Or use a link, where you need, like:

```erb
<%= link_to 'Buy', paysera_payment_path(params: params) %>
``` 

Please have in mind you have to setup the url's and parameters according to the Paysera documentation.

## TODO List

* Add controller which will handle paysera_payment_path
* Make better error methods and notifications
* Add rest functionality for Paysera, like donation, sms support, e-wallet and other.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
