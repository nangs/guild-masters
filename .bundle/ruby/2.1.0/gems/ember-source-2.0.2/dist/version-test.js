semver = require('semver');

console.log('Allows 2.0.0: ' + semver.satisfies('2.0.0', '~1.0.0'));
console.log('Allows 1.3.0: ' + semver.satisfies('1.3.0', '~1.0.0'));
console.log('Allows 1.2.0: ' + semver.satisfies('1.2.0', '~1.0.0'));
console.log('Allows 1.1.0: ' + semver.satisfies('1.1.0', '~1.0.0'));


console.log('Allows 2.0.0: ' + semver.satisfies('2.0.0', '~1'));
console.log('Allows 1.3.0: ' + semver.satisfies('1.3.0', '~1'));
console.log('Allows 1.2.0: ' + semver.satisfies('1.2.0', '~1'));
console.log('Allows 1.1.0: ' + semver.satisfies('1.1.0', '~1'));

