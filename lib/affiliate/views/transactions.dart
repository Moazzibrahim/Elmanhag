import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/theme/theme_provider.dart';
import '../../controller/affiliate_provider.dart';
import '../../models/affiliate_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  AffiliateDate? affiliateData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    ApiService apiService = ApiService();
    AffiliateDate? data = await apiService.fetchUserProfile(context);

    setState(() {
      affiliateData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Container(
          decoration: isDarkMode
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Ellipse 198.png'),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: redcolor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 50),
                    const Center(
                      child: Text(
                        'المعاملات',
                        style: TextStyle(fontSize: 20, color: redcolor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.transparent,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    indicator: BoxDecoration(
                      color: redcolor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        isDarkMode ? Colors.white54 : redcolor,
                    tabs: const [
                      _CustomTab(text: 'المسحوبات'),
                      _CustomTab(text: 'العمولات'),
                    ],
                  ),
                ),
                SizedBox(
                    height: 10.h), // Add spacing between TabBar and content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : TabBarView(
                            children: [
                              _buildPayoutTab(),
                              _buildCommissionTab(),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Payout Tab Content
  Widget _buildPayoutTab() {
    if (affiliateData == null) return const Text('No data available');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Payout Information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTransactionButton(
                'Total Payout',
                '${affiliateData!.totalPayout} ج.م',
                redcolor,
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Payout History:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildTransactionTable(affiliateData!.user.payoutHistory),
        ],
      ),
    );
  }

  Widget _buildCommissionTab() {
    if (affiliateData == null) return const Text('No data available');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Commission Information
          const Text(
            'Commission History:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCommissionTable(affiliateData!.user.affiliateHistory),
        ],
      ),
    );
  }

// Commission Table
  Widget _buildCommissionTable(List<AffiliateHistory> affiliateHistory) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Center(
                      child: Text('اسم الطالب',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('الخدمة',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('العمولة',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('التاريخ',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
            ],
          ),
          const Divider(),
          ...affiliateHistory.map((commission) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Center(child: Text(commission.student.name))),
                  Expanded(child: Center(child: Text(commission.service))),
                  Expanded(
                      child:
                          Center(child: Text('${commission.commission} ج.م'))),
                  Expanded(child: Center(child: Text(commission.date))),
                ],
              ),
            );
          // ignore: unnecessary_to_list_in_spreads
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTransactionButton(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Transaction Table
  Widget _buildTransactionTable(List<PayoutHistory> payoutHistory) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Center(
                      child: Text('التاريخ',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('المبلغ',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text('الحالة',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
            ],
          ),
          const Divider(),
          ...payoutHistory.map((transaction) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Center(child: Text(transaction.date))),
                  Expanded(
                      child: Center(child: Text('${transaction.amount} ج.م'))),
                  Expanded(
                    child: Center(
                      child: transaction.status == 1
                          ? const Text(
                              'تمت',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ) // Completed
                          : GestureDetector(
                              onTap: () {
                                _showRejectedReasonDialog(
                                    context, transaction.rejectedReason);
                              },
                              child: const Text(
                                'مرفوضة',
                                style: TextStyle(
                                  color: redcolor, // Highlight rejected status
                                  fontWeight: FontWeight.bold,
                                  decoration:
                                      TextDecoration.underline, // Clickable
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          // ignore: unnecessary_to_list_in_spreads
          }).toList(),
        ],
      ),
    );
  }

  void _showRejectedReasonDialog(BuildContext context, String rejectedReason) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: const Text(
            'سبب الرفض',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            rejectedReason.isEmpty ? 'لم يتم توفير سبب' : rejectedReason,
            style: const TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'حسنا',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CustomTab extends StatelessWidget {
  final String text;

  const _CustomTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
