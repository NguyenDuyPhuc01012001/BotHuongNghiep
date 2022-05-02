import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/styles.dart';
import 'package:huong_nghiep/utils/constants.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeValue = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor:
          themeValue == Brightness.dark ? Color(0xff262626) : Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: themeValue == Brightness.dark
            ? Color(0xff3C3A3A)
            : Color(0xffBFBFBF),
        title: Text(
          'Tìm hiểu bản thân nha ',
          style: TextStyle(
              color:
                  themeValue == Brightness.dark ? Colors.white : Colors.black),
        ),
      ),
      body: Column(
        children: [
          Text('s'),
          Accordion(
            // maxOpenSections: 2,
            headerBackgroundColorOpened: Colors.black54,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            contentBackgroundColor: Colors.yellow,
            // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            // sectionClosingHapticFeedback: SectionHapticFeedback.light,
            // openAndCloseAnimation: false,
            children: [
              AccordionSection(
                isOpen: true,
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.black,
                headerBackgroundColorOpened: Colors.red,
                header: Text('Introduction', style: ktsHeaderAccordion),
                content: Text(loremIpsum, style: ktsContentAccordion),
                // contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                // sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                // sectionClosingHapticFeedback: SectionHapticFeedback.vibrate,
              ),
              // AccordionSection(
              //   isOpen: true,
              //   leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
              //   header: Text('About Us', style: ktsHeaderAccordion),
              //   contentBorderColor: const Color(0xffffffff),
              //   headerBackgroundColorOpened: Colors.amber,
              //   content: Row(
              //     children: [
              //       const Icon(Icons.compare_rounded,
              //           size: 120, color: Colors.orangeAccent),
              //       Flexible(
              //           flex: 1,
              //           child: Text(loremIpsum, style: ktsContentAccordion)),
              //     ],
              //   ),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.food_bank, color: Colors.white),
              //   header: Text('Company Info', style: ktsHeaderAccordion),
              //   content: DataTable(
              //     sortAscending: true,
              //     sortColumnIndex: 1,
              //     dataRowHeight: 40,
              //     showBottomBorder: false,
              //     columns: [
              //       DataColumn(
              //           label: Text('ID', style: contentStyleHeader),
              //           numeric: true),
              //       DataColumn(
              //           label: Text('Description', style: contentStyleHeader)),
              //       DataColumn(
              //           label: Text('Price', style: contentStyleHeader),
              //           numeric: true),
              //     ],
              //     rows: [
              //       DataRow(
              //         cells: [
              //           DataCell(Text('1',
              //               style: ktsContentAccordion,
              //               textAlign: TextAlign.right)),
              //           DataCell(Text('Fancy Product', style: ktsContentAccordion)),
              //           DataCell(Text(r'$ 199.99',
              //               style: ktsContentAccordion, textAlign: TextAlign.right))
              //         ],
              //       ),
              //       DataRow(
              //         cells: [
              //           DataCell(Text('2',
              //               style: ktsContentAccordion,
              //               textAlign: TextAlign.right)),
              //           DataCell(
              //               Text('Another Product', style: ktsContentAccordion)),
              //           DataCell(Text(r'$ 79.00',
              //               style: ktsContentAccordion, textAlign: TextAlign.right))
              //         ],
              //       ),
              //       DataRow(
              //         cells: [
              //           DataCell(Text('3',
              //               style: ktsContentAccordion,
              //               textAlign: TextAlign.right)),
              //           DataCell(
              //               Text('Really Cool Stuff', style: ktsContentAccordion)),
              //           DataCell(Text(r'$ 9.99',
              //               style: ktsContentAccordion, textAlign: TextAlign.right))
              //         ],
              //       ),
              //       DataRow(
              //         cells: [
              //           DataCell(Text('4',
              //               style: ktsContentAccordion,
              //               textAlign: TextAlign.right)),
              //           DataCell(Text('Last Product goes here',
              //               style: ktsContentAccordion)),
              //           DataCell(Text(r'$ 19.99',
              //               style: ktsContentAccordion, textAlign: TextAlign.right))
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.contact_page, color: Colors.white),
              //   header: Text('Contact', style: ktsHeaderAccordion),
              //   content: Wrap(
              //     children: List.generate(
              //         30,
              //         (index) => const Icon(Icons.contact_page,
              //             size: 30, color: Color(0xff999999))),
              //   ),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.computer, color: Colors.white),
              //   header: Text('Jobs', style: ktsHeaderAccordion),
              //   content:
              //       const Icon(Icons.computer, size: 200, color: Color(0xff999999)),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.movie, color: Colors.white),
              //   header: Text('Culture', style: ktsHeaderAccordion),
              //   content:
              //       const Icon(Icons.movie, size: 200, color: Color(0xff999999)),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.people, color: Colors.white),
              //   header: Text('Community', style: ktsHeaderAccordion),
              //   content:
              //       const Icon(Icons.people, size: 200, color: Color(0xff999999)),
              // ),
              // // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.person_add, color: Colors.white),
              //   header: Text('Accordion within Accordion', style: ktsHeaderAccordion),
              //   contentHorizontalPadding: 15,
              //   contentVerticalPadding: 15,
              //   content: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Flexible(
              //         flex: 1,
              //         child: Text(
              //           '\nTo your right you have an accordion nested within an accordion:',
              //           style: ktsContentAccordion,
              //           textAlign: TextAlign.right,
              //         ),
              //       ),
              //       Container(
              //         width: 200,
              //         height: 200,
              //         child: Accordion(
              //           headerBackgroundColor: Colors.blue[200],
              //           headerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              //           contentBackgroundColor: Colors.blue[50],
              //           contentBorderRadius: 10,
              //           children: [
              //             AccordionSection(
              //                 isOpen: false, header: Text('Section #1', style: ktsHeaderAccordion), content: Text('This is sub-accordion #1 ...', style: ktsContentAccordion)),
              //             AccordionSection(
              //                 isOpen: false, header: Text('Section #2', style: ktsHeaderAccordion), content: Text('This is sub-accordion #2 ...', style: ktsContentAccordion)),
              //             AccordionSection(
              //                 isOpen: false, header: Text('Section #3', style: ktsHeaderAccordion), content: Text('This is sub-accordion #3 ...', style: ktsContentAccordion)),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // AccordionSection(
              //   isOpen: false,
              //   leftIcon: const Icon(Icons.map, color: Colors.white),
              //   header: Text('Map', style: ktsHeaderAccordion),
              //   content: const Icon(Icons.map, size: 200, color: Color(0xff999999)),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
