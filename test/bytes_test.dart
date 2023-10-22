import 'package:lazy/lazy.dart';
import 'package:test/test.dart';

void main() {
  test('bytesize equality', () {
    var a = Bytes(4, ByteSize.PB);
    var b = Bytes(4, ByteSize.PB);
    expect(a, equals(b));

    b = Bytes(4000, ByteSize.TB);
    expect(a, equals(b));

    b = Bytes(4e6, ByteSize.GB);
    expect(a, equals(b));

    b = Bytes(4e9, ByteSize.MB);
    expect(a, equals(b));

    b = Bytes(4e12, ByteSize.KB);
    expect(a, equals(b));
  });

  test('bytesize conversion', () {
    var a = Bytes(6, ByteSize.GB);
    var b = Bytes(6, ByteSize.GB);

    expect(a, equals(b.mebiBytes));
    expect(a, equals(b.megaBytes));
    expect(a.tebiBytes, equals(b.megaBytes));
    expect(a.pebiBytes, equals(b.kiloBytes));
  });

  // test('bytes sum operators', () {
  //   var a = Bytes(512, ByteSize.MiB);
  //   var b = Bytes(512, ByteSize.MiB);
  //   expect(a + b, equals(Bytes(1, ByteSize.GiB)));
  // });

  // test bytes product operators
}
