import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class ThermometerPage extends StatefulWidget {
  const ThermometerPage({super.key});

  @override
  State<ThermometerPage> createState() => _ThermometerPageState();
}

class _TempPreset extends StatelessWidget {
  final String label;
  final double celsius;
  final Color color;
  final VoidCallback onTap;

  const _TempPreset({
    required this.label,
    required this.celsius,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fahrenheit = celsius * 9 / 5 + 32;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${celsius.toStringAsFixed(0)}°C / ${fahrenheit.toStringAsFixed(0)}°F',
              style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThermometerPageState extends State<ThermometerPage> {
  double _celsius = 32.0;
  bool _showMinorLabels = true;
  bool _showCelsius = true;
  bool _showFahrenheit = true;
  ds.ThermometerFluidTheme _selectedTheme = ds.ThermometerFluidTheme.redSpirit;
  ds.ThermometerReadoutStyle _readoutStyle =
      ds.ThermometerReadoutStyle.circularWheel;

  // Live Hardware Sensor Simulation
  bool _isLiveSensorStreaming = false;
  bool _autoThemeBasedOnSensor = true;
  Timer? _sensorTimer;

  @override
  void dispose() {
    _sensorTimer?.cancel();
    super.dispose();
  }

  void _toggleLiveSensor(bool enable) {
    setState(() {
      _isLiveSensorStreaming = enable;
    });

    _sensorTimer?.cancel();
    if (enable) {
      _sensorTimer =
          Timer.periodic(const Duration(milliseconds: 1400), (timer) {
        final delta = (math.Random().nextDouble() * 4.0) - 1.8;
        final newTemp = (_celsius + delta).clamp(-15.0, 48.0);
        setState(() {
          _celsius = double.parse(newTemp.toStringAsFixed(1));
          if (_autoThemeBasedOnSensor) {
            _selectedTheme = ds.ThermometerFluidTheme.fromCelsius(_celsius);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fahrenheit = _celsius * 9 / 5 + 32;

    return ds.AppScaffold(
      title: 'Thermometer 100% Realistic',
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Live Device Sensor Simulation Banner
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isLiveSensorStreaming
                    ? [
                        const Color(0xFF10B981).withValues(alpha: 0.18),
                        const Color(0xFF059669).withValues(alpha: 0.08),
                      ]
                    : [
                        const Color(0xFF3B82F6).withValues(alpha: 0.12),
                        const Color(0xFF1D4ED8).withValues(alpha: 0.05),
                      ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isLiveSensorStreaming
                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                    : const Color(0xFF3B82F6).withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isLiveSensorStreaming
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : Colors.blue.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isLiveSensorStreaming
                        ? Icons.sensors_rounded
                        : Icons.bluetooth_searching_rounded,
                    color: _isLiveSensorStreaming
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _isLiveSensorStreaming
                                ? 'جهاز الاستشعار متصل (Live Telemetry)'
                                : 'محاكاة قراءات جهاز الاستشعار (Hardware Sensor)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          if (_isLiveSensorStreaming) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isLiveSensorStreaming
                            ? 'بث مباشر للحرارة من الحساس (ESP32 / BLE Sensor)'
                            : 'تفعيل المحاكاة لاستقبال قيم درجات الحرارة تلقائياً',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: _isLiveSensorStreaming,
                  activeTrackColor:
                      const Color(0xFF10B981).withValues(alpha: 0.4),
                  activeThumbColor: const Color(0xFF10B981),
                  onChanged: _toggleLiveSensor,
                ),
              ],
            ),
          ),

          _section(context, 'Interactive Glass Thermometer', children: [
            // Center Thermometer Widget with 3D Wheel Readout
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1B1F27)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF2C3240)
                        : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ds.ThermometerWidget(
                  celsius: _celsius,
                  showCelsius: _showCelsius,
                  showFahrenheit: _showFahrenheit,
                  showMinorLabels: _showMinorLabels,
                  fluidTheme: _selectedTheme,
                  readoutStyle: _readoutStyle,
                  showSunIcon: false,
                  width: 270,
                  height: 460,
                  interactive:
                      !_isLiveSensorStreaming, // Read-only during live sensor mode
                  onChanged: (newCelsius) {
                    setState(() {
                      _celsius = newCelsius;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _isLiveSensorStreaming
                    ? '⚡ قراءات حية متدفقة من الحساس الخارجي مع حركة انسيابية'
                    : '💡 يمكنك اللمس والسحب المباشر على مقياس الحرارة لتعديل القيمة',
                style: TextStyle(
                  fontSize: 12,
                  color: _isLiveSensorStreaming
                      ? const Color(0xFF10B981)
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Readout Badge
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: _selectedTheme.primary.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  _showCelsius && _showFahrenheit
                      ? '${_celsius.toStringAsFixed(1)}°C  /  ${fahrenheit.toStringAsFixed(1)}°F'
                      : _showCelsius
                          ? '${_celsius.toStringAsFixed(1)}°C'
                          : '${fahrenheit.toStringAsFixed(1)}°F',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _selectedTheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Slider control (only when not streaming)
            if (!_isLiveSensorStreaming)
              Slider(
                value: _celsius,
                min: -30,
                max: 50,
                divisions: 160,
                label: '${_celsius.toStringAsFixed(1)}°C',
                activeColor: _selectedTheme.primary,
                onChanged: (value) {
                  setState(() {
                    _celsius = value;
                  });
                },
              ),
            const SizedBox(height: 12),

            // Readout Style Selector (نمط عرض البكرة الدائرية)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF232731)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF333A48)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.style_rounded,
                          size: 18, color: Colors.blueAccent),
                      SizedBox(width: 8),
                      Text(
                        'شكل ونمط عرض القيمة الحالية (Readout Style)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('بكرة دائرية (3 شرطات)'),
                        selected: _readoutStyle ==
                            ds.ThermometerReadoutStyle.circularWheel,
                        selectedColor:
                            _selectedTheme.primary.withValues(alpha: 0.25),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _readoutStyle =
                                  ds.ThermometerReadoutStyle.circularWheel;
                            });
                          }
                        },
                      ),
                      ChoiceChip(
                        label: const Text('بادج بسيط (Badge)'),
                        selected: _readoutStyle ==
                            ds.ThermometerReadoutStyle.simpleBadge,
                        selectedColor:
                            _selectedTheme.primary.withValues(alpha: 0.25),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _readoutStyle =
                                  ds.ThermometerReadoutStyle.simpleBadge;
                            });
                          }
                        },
                      ),
                      ChoiceChip(
                        label: const Text('إخفاء (None)'),
                        selected:
                            _readoutStyle == ds.ThermometerReadoutStyle.none,
                        selectedColor:
                            _selectedTheme.primary.withValues(alpha: 0.25),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _readoutStyle = ds.ThermometerReadoutStyle.none;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Scale Display Option Switches (°C / °F)
            Material(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF232731)
                  : const Color(0xFFF8FAFC),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF333A48)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'إظهار مقياس السيلزيوس (°C) على اليمين',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'المقياس المتري المعتمد في الوطن العربي وأوروبا',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _showCelsius,
                    activeThumbColor: _selectedTheme.primary,
                    activeTrackColor:
                        _selectedTheme.primary.withValues(alpha: 0.4),
                    onChanged: (val) {
                      setState(() {
                        _showCelsius = val;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text(
                      'إظهار مقياس الفهرنهايت (°F) على اليسار',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'المقياس المستخدم في الولايات المتحدة',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _showFahrenheit,
                    activeThumbColor: _selectedTheme.primary,
                    activeTrackColor:
                        _selectedTheme.primary.withValues(alpha: 0.4),
                    onChanged: (val) {
                      setState(() {
                        _showFahrenheit = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Additional Display Options (Micro-Labels & Auto-Theme)
            Material(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF232731)
                  : const Color(0xFFF8FAFC),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF333A48)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text(
                      'أرقام التدريج الدقيق (Micro-Labels)',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'إظهار أرقام مصغرة عند كل شرطة فرعية مثل البكارة والمسطرة',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _showMinorLabels,
                    activeThumbColor: _selectedTheme.primary,
                    activeTrackColor:
                        _selectedTheme.primary.withValues(alpha: 0.4),
                    onChanged: (val) {
                      setState(() {
                        _showMinorLabels = val;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text(
                      'تغيير لون السائل تلقائياً حسب حرارة الحساس (Auto-Theme)',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'يتغير اللون ديناميكياً (أزرق للبارد، أخضر للمعتدل، أحمر للحار)',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _autoThemeBasedOnSensor,
                    activeThumbColor: _selectedTheme.primary,
                    activeTrackColor:
                        _selectedTheme.primary.withValues(alpha: 0.4),
                    onChanged: (val) {
                      setState(() {
                        _autoThemeBasedOnSensor = val;
                        if (val) {
                          _selectedTheme =
                              ds.ThermometerFluidTheme.fromCelsius(_celsius);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ]),

          // Standalone 3D Cylindrical Wheel Readout Showcase
          _section(context,
              '3D Rolling Wheel Readout (بكرة القراءة الأسطوانية الدائرية)',
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1B1F27)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF2C3240)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'تأثير البكرة ثلاثية الأبعاد: الشرطة العلوية والسفلية شبه مختفية (تلاشي 60%) والوسطى واضحة تماماً مع القيمة الحية:',
                        style: TextStyle(
                            fontSize: 12.5, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ds.ThermometerWheelReadout(
                                celsius: _celsius,
                                unit: '°C',
                                activeColor: _selectedTheme.primary,
                              ),
                              const SizedBox(height: 8),
                              const Text('مقياس °C المتري',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            children: [
                              ds.ThermometerWheelReadout(
                                celsius: fahrenheit,
                                unit: '°F',
                                activeColor: _selectedTheme.primary,
                              ),
                              const SizedBox(height: 8),
                              const Text('مقياس °F الأمريكي',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),

          // Fluid Theme Switcher
          _section(context, 'Fluid Themes (أنواع وثيمات السائل)', children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ds.ThermometerFluidTheme.values.map((theme) {
                final isSelected = _selectedTheme == theme;
                final name = switch (theme) {
                  ds.ThermometerFluidTheme.redSpirit => 'الكحول الأحمر (Red)',
                  ds.ThermometerFluidTheme.mercury => 'الزئبق الفضي (Mercury)',
                  ds.ThermometerFluidTheme.cryoBlue =>
                    'الأزرق الثلجي (Cryo Blue)',
                  ds.ThermometerFluidTheme.emerald => 'الزمرد الأخضر (Emerald)',
                  ds.ThermometerFluidTheme.amber =>
                    'الكهرمان البرتقالي (Amber)',
                };

                return ChoiceChip(
                  label: Text(name),
                  selected: isSelected,
                  selectedColor: theme.primary.withValues(alpha: 0.25),
                  side: BorderSide(
                    color: isSelected
                        ? theme.primary
                        : Colors.grey.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  avatar: CircleAvatar(
                    backgroundColor: theme.primary,
                    radius: 8,
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedTheme = theme;
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ]),

          _section(context, 'Temperature Presets (نقاط ضبط سريعة)', children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _TempPreset(
                  label: 'Freezing (تجمّد)',
                  celsius: 0,
                  color: Colors.blue,
                  onTap: () => _setTemperature(0),
                ),
                _TempPreset(
                  label: 'Cold (بارد)',
                  celsius: 10,
                  color: Colors.lightBlue,
                  onTap: () => _setTemperature(10),
                ),
                _TempPreset(
                  label: 'Room (غرفة)',
                  celsius: 22,
                  color: Colors.green,
                  onTap: () => _setTemperature(22),
                ),
                _TempPreset(
                  label: 'Warm (دافئ)',
                  celsius: 30,
                  color: Colors.orange,
                  onTap: () => _setTemperature(30),
                ),
                _TempPreset(
                  label: 'Hot (حار)',
                  celsius: 40,
                  color: Colors.deepOrange,
                  onTap: () => _setTemperature(40),
                ),
                _TempPreset(
                  label: 'Extreme (شديد الحرارة)',
                  celsius: 48,
                  color: Colors.red,
                  onTap: () => _setTemperature(48),
                ),
                _TempPreset(
                  label: 'Sub-Zero (تحت الصفر)',
                  celsius: -20,
                  color: Colors.cyan,
                  onTap: () => _setTemperature(-20),
                ),
              ],
            ),
          ]),

          _section(context, 'Different Sizes (مقاسات متعددة)', children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ds.ThermometerWidget(
                      celsius: 25,
                      width: 160,
                      height: 320,
                      showMinorLabels: false,
                      fluidTheme: _selectedTheme,
                    ),
                    const SizedBox(height: 8),
                    const Text('Compact (صغير)',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    ds.ThermometerWidget(
                      celsius: 25,
                      width: 230,
                      height: 440,
                      showMinorLabels: true,
                      fluidTheme: _selectedTheme,
                    ),
                    const SizedBox(height: 8),
                    const Text('Standard (قياسي)',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ]),

          _section(context, 'Weather Scenarios (حالات الطقس)', children: [
            GridView.count(
              crossAxisCount: context.isWindowCompact ? 1 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.52,
              children: const [
                _WeatherCard(
                  title: 'Winter Morning',
                  celsius: -9,
                  icon: Icons.ac_unit,
                  color: Colors.blue,
                  theme: ds.ThermometerFluidTheme.cryoBlue,
                ),
                _WeatherCard(
                  title: 'Spring Day',
                  celsius: 18,
                  icon: Icons.wb_sunny_outlined,
                  color: Colors.green,
                  theme: ds.ThermometerFluidTheme.emerald,
                ),
                _WeatherCard(
                  title: 'Summer Heat',
                  celsius: 38,
                  icon: Icons.wb_sunny,
                  color: Colors.orange,
                  theme: ds.ThermometerFluidTheme.redSpirit,
                ),
                _WeatherCard(
                  title: 'Autumn Breeze',
                  celsius: 14,
                  icon: Icons.air,
                  color: Colors.brown,
                  theme: ds.ThermometerFluidTheme.amber,
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, String title,
      {required List<Widget> children}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  void _setTemperature(double c) {
    setState(() {
      _celsius = c;
    });
  }
}

class _WeatherCard extends StatelessWidget {
  final String title;
  final double celsius;
  final IconData icon;
  final Color color;
  final ds.ThermometerFluidTheme theme;

  const _WeatherCard({
    required this.title,
    required this.celsius,
    required this.icon,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final fahrenheit = celsius * 9 / 5 + 32;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ds.ThermometerWidget(
              celsius: celsius,
              width: 140,
              height: 250,
              showMinorLabels: false,
              fluidTheme: theme,
              interactive: false,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${celsius.toStringAsFixed(0)}°C / ${fahrenheit.toStringAsFixed(0)}°F',
            style: TextStyle(
              color: color.withValues(alpha: 0.85),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
