// ignore_for_file: constant_identifier_names

class Bytes {
  late final double value;
  final ByteSize size;

  Bytes(double bytes, this.size) {
    value = bytes * size.value;
  }

  Bytes get kiloBytes => Bytes(value / ByteSize.KB.value, ByteSize.KB);
  Bytes get megaBytes => Bytes(value / ByteSize.MB.value, ByteSize.MB);
  Bytes get gigaBytes => Bytes(value / ByteSize.GB.value, ByteSize.GB);
  Bytes get teraBytes => Bytes(value / ByteSize.TB.value, ByteSize.TB);
  Bytes get petaBytes => Bytes(value / ByteSize.PB.value, ByteSize.PB);

  Bytes get kibiBytes => Bytes(value / ByteSize.KiB.value, ByteSize.KiB);
  Bytes get mebiBytes => Bytes(value / ByteSize.MiB.value, ByteSize.MiB);
  Bytes get gibiBytes => Bytes(value / ByteSize.GiB.value, ByteSize.GiB);
  Bytes get tebiBytes => Bytes(value / ByteSize.TiB.value, ByteSize.TiB);
  Bytes get pebiBytes => Bytes(value / ByteSize.PiB.value, ByteSize.PiB);

  @override
  bool operator ==(Object other) {
    if (other is! Bytes) return false;
    return value == other.value;
  }

  @override
  int get hashCode => value.hashCode ^ size.hashCode;

  @override
  String toString() => '${value.toStringAsPrecision(3)} $size';

  bool operator <(Bytes other) => kiloBytes < other.kiloBytes;
  bool operator >(Bytes other) => kiloBytes > other.kiloBytes;
  bool operator <=(Bytes other) => this < other || this == other;
  bool operator >=(Bytes other) => this > other || this == other;
  // Bytes operator +(Bytes other) => Bytes(value + other.value, size);
  // Bytes operator -(Bytes other) => Bytes(value - other.value, size);
}

class ByteSize {
  final double value;

  static const KB = ByteSize._(1000.0);
  static const KiB = ByteSize._(1024.0);
  static const MB = ByteSize._(1e6);
  static const MiB = ByteSize._(1048576.0);
  static const GB = ByteSize._(1e9);
  static const GiB = ByteSize._(1073741824.0);
  static const TB = ByteSize._(1e12);
  static const TiB = ByteSize._(1099511627776.0);
  static const PB = ByteSize._(1e15);
  static const PiB = ByteSize._(1125899906842624.0);

  static ByteSize? parse(String str) => switch (str) {
        'KB' => KB,
        'KiB' => KiB,
        'MB' => MB,
        'MiB' => MiB,
        'GB' => GB,
        'GiB' => GiB,
        'TB' => TB,
        'TiB' => TiB,
        'PB' => PB,
        'PiB' => PiB,
        _ => null,
      };

  const ByteSize._(this.value);

  @override
  String toString() => switch (this) {
        KB => 'KB',
        KiB => 'KiB',
        MB => 'MB',
        MiB => 'MiB',
        GB => 'GiB',
        GiB => 'GiB',
        TB => 'TB',
        TiB => 'TiB',
        PB => 'PB',
        PiB => 'PiB',
        _ => throw 'unreachable',
      };
}
