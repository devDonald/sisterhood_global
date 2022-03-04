import 'package:flutter_linkify/flutter_linkify.dart';

final _phoneRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

class PhoneLinkifier extends Linkifier {
  const PhoneLinkifier();

  @override
  List<LinkifyElement> parse(elements, options) {
    final list = <LinkifyElement>[];

    elements.forEach((element) {
      if (element is PhoneElement) {
        final match = _phoneRegex.firstMatch(element.text);

        if (match == null) {
          list.add(element);
        } else {
          final text = element.text.replaceFirst(match.group(0)!, '');

          if (match.group(1)?.isNotEmpty == true) {
            list.add(PhoneElement(match.group(1)!));
          }

          if (text.isNotEmpty) {
            list.addAll(parse([PhoneElement(text)], options));
          }
        }
      } else {
        list.add(element);
      }
    });

    return list;
  }
}

/// Represents an element containing an email address
class PhoneElement extends LinkableElement {
  final String phone;

  PhoneElement(this.phone) : super(phone, 'tel:$phone');

  @override
  String toString() {
    return "PhoneElement: '$phone' ($text)";
  }

  @override
  bool operator ==(other) => equals(other);

  @override
  bool equals(other) =>
      other is PhoneElement && super.equals(other) && other.phone == phone;
}
