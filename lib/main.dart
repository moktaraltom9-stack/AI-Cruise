import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const AICruiseApp());
}
class AICruiseApp extends StatefulWidget {
  const AICruiseApp({super.key});
  @override
  State<AICruiseApp> createState() => _AICruiseAppState();
}
class _AICruiseAppState extends State<AICruiseApp> {
  Locale _locale = const Locale('ar');
  void _toggleLanguage() {
    setState(() {
      _locale = _locale.languageCode == 'ar' 
          ? const Locale('en') 
          : const Locale('ar');
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Cruise Ultimate',
      locale: _locale,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070712),
        fontFamily: 'Roboto',
      ),
      home: MainHomeScreen(onToggleLanguage: _toggleLanguage, currentLang: _locale.languageCode),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  final VoidCallback onToggleLanguage;
  final String currentLang;
  const MainHomeScreen({super.key, required this.onToggleLanguage, required this.currentLang});
  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}
class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  bool _isSystemActive = true;
  // دالة فتح واتساب الفعلية
  Future<void> _openWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/?text=${Uri.encodeComponent("مرحباً، أريد الاستفسار عن خدمات تطبيق AI Cruise المتكامل")}");
    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch WhatsApp");
      }
    } catch (e) {
      debugPrint("Error launching WhatsApp: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isAr = widget.currentLang == 'ar';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // الهيدر العلوي
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, color: Colors.cyanAccent),
                    onPressed: () => _showSettingsDialog(context, isAr),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.language, color: Colors.purpleAccent),
                        onPressed: widget.onToggleLanguage,
                        tooltip: 'Switch Language',
                      ),
                      Column(
                        crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AI CRUISE',
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            isAr ? 'النظام الذكي المتكامل' : 'Ultimate AI System',
                            style: const TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // حالة النظام والتحكم العام
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF101022),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _isSystemActive ? Colors.greenAccent.withOpacity(0.5) : Colors.redAccent.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch(
                      value: _isSystemActive,
                      activeColor: Colors.greenAccent,
                      onChanged: (val) {
                        setState(() {
                          _isSystemActive = val;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(val ? (isAr ? 'تم تشغيل النظام عامة' : 'System activated') : (isAr ? 'تم إيقاف النظام عامة' : 'System deactivated'))),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAr ? 'التحكم العام في الجهاز والنظام' : 'General System & Device Control',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          _isSystemActive ? (isAr ? 'الحالة: نشط ويعمل بكفاءة' : 'Status: Active') : (isAr ? 'الحالة: متوقف مؤقتاً' : 'Status: Paused'),
                          style: TextStyle(color: _isSystemActive ? Colors.greenAccent : Colors.redAccent, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // أزرار سريعة (واتساب وتحكم التشغيل)
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      title: isAr ? 'تواصل واتساب' : 'WhatsApp',
                      subtitle: isAr ? 'مراسلة فورية' : 'Direct Chat',
                      icon: Icons.chat_rounded,
                      color: Colors.greenAccent,
                      borderColor: Colors.green,
                      isAr: isAr,
                      onTap: _openWhatsApp,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      title: isAr ? 'المساعد الصوتي' : 'Voice Assistant',
                      subtitle: isAr ? 'تحدث واستمع للصوت' : 'Speech & Audio',
                      icon: Icons.mic_rounded,
                      color: Colors.cyanAccent,
                      borderColor: Colors.cyan,
                      isAr: isAr,
                      onTap: () => _showVoiceAssistantModal(context, isAr),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // لوحة الأدوات الشاملة
              Text(
                isAr ? 'أدوات الذكاء الاصطناعي والخدمات' : 'AI Tools & Services',
                style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildToolCard(
                    title: isAr ? 'المحادثة والنصوص' : 'AI Chat & Text',
                    subtitle: isAr ? 'كتابة وردود ذكية' : 'Smart replies & writing',
                    icon: Icons.auto_awesome_rounded,
                    isAr: isAr,
                    onTap: () => _showChatModal(context, isAr),
                  ),
                  _buildToolCard(
                    title: isAr ? 'إنشاء الفيديوهات' : 'AI Video Gen',
                    subtitle: isAr ? 'إنتاج وتصدير سينمائي' : 'Cinematic creation',
                    icon: Icons.video_collection_rounded,
                    isAr: isAr,
                    isHighlighted: true,
                    onTap: () => _showVideoPaymentDialog(context, isAr),
                  ),
                  _buildToolCard(
                    title: isAr ? 'توليد الصور والفن' : 'Image Generator',
                    subtitle: isAr ? 'حول أفكارك لصور' : 'Turn thoughts to art',
                    icon: Icons.image_rounded,
                    isAr: isAr,
                    onTap: () {},
                  ),
                  _buildToolCard(
                    title: isAr ? 'التحكم والخروج' : 'Control & Exit',
                    subtitle: isAr ? 'إدارة الجلسة بالكامل' : 'Full session management',
                    icon: Icons.power_settings_new_rounded,
                    isAr: isAr,
                    onTap: () => _showExitDialog(context, isAr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF090915),
          border: Border(top: BorderSide(color: Colors.cyanAccent.withOpacity(0.2))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.white54,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: isAr ? 'الرئيسية' : 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.mic_external_on_rounded),
              label: isAr ? 'الصوتيات' : 'Audio',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.payment_rounded),
              label: isAr ? 'الاشتراكات' : 'Billing',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.exit_to_app_rounded),
              label: isAr ? 'خروج' : 'Exit',
            ),
          ],
        ),
      ),
    );
  }
  // نافذة المحادثة والكتابة
  void _showChatModal(BuildContext context, bool isAr) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101022),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(isAr ? 'المحادثة الذكية وكتابة الردود' : 'AI Chat & Smart Typing', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: isAr ? 'اكتب ما تريد وسيقوم النظام بالرد فورا...' : 'Type anything and system will reply...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF181830),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(isAr ? 'تم توليد الرد وإرساله بنجاح!' : 'Reply generated successfully!')),
                );
              },
              child: Text(isAr ? 'إرسال وتوليد الرد' : 'Send & Generate'),
            ),
          ],
        ),
      ),
    );
  }
  // نافذة المساعد الصوتي
  void _showVoiceAssistantModal(BuildContext context, bool isAr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101022),
        title: Text(isAr ? 'المساعد الصوتي التفاعلي' : 'Voice Assistant', style: const TextStyle(color: Colors.cyanAccent)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.mic, size: 60, color: Colors.cyanAccent),
            const SizedBox(height: 15),
            Text(
              isAr ? 'تحدث الآن، وسيقوم النظام بتحويل كلامك لنص أو الرد عليك بصوت واضح.' : 'Speak now, system will convert speech or reply in audio.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isAr ? 'إغلاق' : 'Close', style: const TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isAr ? 'جاري تشغيل التسجيل الصوتي...' : 'Playing voice response...')),
              );
            },
            child: Text(isAr ? 'تشغيل الصوت' : 'Play Audio'),
          ),
        ],
      ),
    );
  }
  // نافذة الدفع والفيديو
  void _showVideoPaymentDialog(BuildContext context, bool isAr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101022),
        title: Text(isAr ? 'إنشاء الفيديوهات المدفوعة' : 'AI Video Generation', style: const TextStyle(color: Colors.purpleAccent)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(isAr ? 'احصل على تصدير غير محدود للفيديوهات بجودة سينمائية عالية.' : 'Get unlimited cinematic AI video exports.', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 15),
            const Text('\$9.99 / month', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isAr ? 'تم إتمام الدفع بنجاح، جاري توليد الفيديو...' : 'Payment successful, generating video...')),
              );
            },
            child: Text(isAr ? 'إتمام الدفع' : 'Pay Now'),
          ),
        ],
      ),
    );
  }
  // نافذة الإعدادات العامة
  void _showSettingsDialog(BuildContext context, bool isAr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101022),
        title: Text(isAr ? 'إعدادات الجهاز والنظام' : 'System & Device Settings', style: const TextStyle(color: Colors.cyanAccent)),
        content: Text(isAr ? 'إدارة التنبيهات، والأداء، وخيارات الاتصال.' : 'Manage notifications, performance, and connections.', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(isAr ? 'حفظ وإغلاق' : 'Save & Close')),
        ],
      ),
    );
  }
  // خروج من التطبيق / الجلسة
  void _showExitDialog(BuildContext context, bool isAr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF101022),
        title: Text(isAr ? 'الخروج من التطبيق' : 'Exit Application', style: const TextStyle(color: Colors.redAccent)),
        content: Text(isAr ? 'هل أنت متأكد من رغبتك في تسجيل الخروج وإيقاف الجلسة العامة؟' : 'Are you sure you want to exit and end the session?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(isAr ? 'إلغاء' : 'Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(isAr ? 'تم إيقاف الجلسة بنجاح.' : 'Session ended.')),
              );
            },
            child: Text(isAr ? 'خروج' : 'Exit'),
          ),
        ],
      ),
    );
  }
  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color borderColor,
    required bool isAr,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF101022),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor.withOpacity(0.6), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isAr) ...[
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 9)),
                ],
              ),
            ),
            if (isAr) ...[
              const SizedBox(width: 8),
              Icon(icon, color: color, size: 22),
            ],
          ],
        ),
      ),
    );
  }
  Widget _buildToolCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isAr,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF101022),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlighted ? Colors.purpleAccent : Colors.cyanAccent.withOpacity(0.2),
            width: isHighlighted ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (isHighlighted ? Colors.purpleAccent : Colors.cyanAccent).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: isHighlighted ? Colors.purpleAccent : Colors.cyanAccent, size: 20),
            ),
            const Spacer(),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: isAr ? TextAlign.right : TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white54, fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}
