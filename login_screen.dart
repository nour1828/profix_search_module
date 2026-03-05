import 'package:flutter/material.dart';
// استدعاء ملفاتك بالأسماء اللي إنتِ مسمياها
import 'search_screen.dart';
import 'technican_requests_screen.dart';

class AuthScreen extends StatefulWidget {
  final String role; // بنستقبل 'customer' أو 'technician'
  const AuthScreen({super.key, required this.role});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true; // متغير للتبديل بين اللوجن والاشتراك
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>(); // مفتاح عشان نختبر الـ @

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  // لون الصفحة حسب النوع (أزرق للعميل، وأخضر أو برتقالي للفني)
  Color get primaryColor => widget.role == 'technician'
      ? const Color(0xFF3D5CFF)
      : const Color(0xFF3D5CFF);

  void _handleSubmit() {
    // اختبار الإيميل والباسورد
    if (_formKey.currentState!.validate()) {
      if (widget.role == 'technician') {
        // لو فني يروح لصفحة البحث بتاعته
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TechnicanRequestsScreen(),
          ),
        );
      } else {
        // لو عميل يروح لصفحة السيرش
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // أيقونة الشخص اللي في الفيديو بتاعك
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isLogin ? Icons.person_outline : Icons.person_add_alt,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _isLogin ? 'Welcome Back!' : 'Create Account',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _isLogin
                    ? 'Sign in to continue'
                    : 'Join us as a ${widget.role}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // لو اشتراك نظهر خانة الاسم
              if (!_isLogin) ...[
                _buildField(
                  _nameCtrl,
                  'Full Name',
                  Icons.person_outline,
                  false,
                ),
                const SizedBox(height: 16),
              ],

              // خانة الإيميل مع شرط الـ @
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                // ده اللي بيخلي الجهاز يحفظ الإيميل ويطلحه كـ اقتراح
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // أول ما يخلص كتابة ويدوس Enter ينقله لخانة الباسورد
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter email";
                  if (!value.contains('@')) return "Email must contain @";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // خانة الباسورد
              TextFormField(
                controller: _passwordCtrl,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                autofillHints: const [AutofillHints.password], // لحفظ الباسورد
                textInputAction:
                    TextInputAction.done, // يخلي زرار الكيبورد علامة صح
                onFieldSubmitted: (value) {
                  _handleSubmit(); // ينفذ الدخول لما تدوسي Enter
                },
                validator: (value) => (value != null && value.length < 6)
                    ? "Min 6 characters"
                    : null,
              ),

              const SizedBox(height: 30),

              // زرار الدخول
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _handleSubmit,
                  child: Text(
                    _isLogin ? 'Sign In' : 'Create Account',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // التبديل بين تسجيل الدخول والاشتراك
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin
                        ? "Don't have an account? "
                        : "Already have an account? ",
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin ? 'Sign Up' : 'Sign In',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    IconData icon,
    bool isPass,
  ) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
