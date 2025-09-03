import 'package:flutter/material.dart';

class DateTimeTools extends StatefulWidget {
  const DateTimeTools({super.key});

  @override
  _DateTimeToolsState createState() => _DateTimeToolsState();
}

class _DateTimeToolsState extends State<DateTimeTools> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  Duration _countdownDuration = const Duration(hours: 1);
  Duration _timerDuration = Duration.zero;
  bool _isTimerRunning = false;
  String _timeZoneDifference = '+0:00';

  final List<String> _timeZones = [
    'UTC-12:00', 'UTC-11:00', 'UTC-10:00', 'UTC-09:00', 'UTC-08:00', 'UTC-07:00', 'UTC-06:00',
    'UTC-05:00', 'UTC-04:00', 'UTC-03:00', 'UTC-02:00', 'UTC-01:00', 'UTC+00:00', 'UTC+01:00',
    'UTC+02:00', 'UTC+03:00', 'UTC+04:00', 'UTC+05:00', 'UTC+06:00', 'UTC+07:00', 'UTC+08:00',
    'UTC+09:00', 'UTC+10:00', 'UTC+11:00', 'UTC+12:00', 'UTC+13:00', 'UTC+14:00'
  ];
  String _selectedTimeZone = 'UTC+00:00';

  @override
  void initState() {
    super.initState();
    _calculateTimeZoneDifference();
    _timerDuration = _countdownDuration;
  }

  void _calculateTimeZoneDifference() {
    // Cálculo simplificado da diferença de fuso horário
    try {
      String offset = _selectedTimeZone.replaceFirst('UTC', '');
      bool isNegative = offset.startsWith('-');
      offset = offset.replaceFirst(RegExp(r'[+-]'), '');
      
      List<String> parts = offset.split(':');
      int hours = int.parse(parts[0]);
      int minutes = parts.length > 1 ? int.parse(parts[1]) : 0;
      
      int totalMinutes = hours * 60 + minutes;
      if (isNegative) totalMinutes = -totalMinutes;
      
      // Diferença em relação ao fuso local (simplificado)
      DateTime now = DateTime.now();
      DateTime utcNow = now.toUtc();
      Duration localOffset = now.difference(utcNow);
      
      int localTotalMinutes = localOffset.inMinutes;
      int difference = totalMinutes - localTotalMinutes;
      
      bool isDiffNegative = difference < 0;
      difference = difference.abs();
      
      int diffHours = difference ~/ 60;
      int diffMinutes = difference % 60;
      
      setState(() {
        _timeZoneDifference = '${isDiffNegative ? '-' : '+'}$diffHours:${diffMinutes.toString().padLeft(2, '0')}';
      });
    } catch (e) {
      setState(() {
        _timeZoneDifference = 'Erro';
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    
    // Simulação de timer (em app real, usaríamos um Timer periódico)
    Future.delayed(const Duration(seconds: 1), () {
      if (_isTimerRunning && _timerDuration.inSeconds > 0) {
        setState(() {
          _timerDuration = _timerDuration - const Duration(seconds: 1);
        });
        _startTimer();
      } else {
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _timerDuration = _countdownDuration;
      _isTimerRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ferramentas de Data e Hora'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Conversor'),
              Tab(text: 'Diferença'),
              Tab(text: 'Temporizador'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Conversor de Fusos Horários
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Conversor de Fusos Horários',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Data e Hora Local:'),
                      const SizedBox(width: 10),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} ${_selectedTime.format(context)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Selecionar Data'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: const Text('Selecionar Hora'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedTimeZone,
                    items: _timeZones.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTimeZone = newValue!;
                        _calculateTimeZoneDifference();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Fuso Horário de Destino',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Diferença: $_timeZoneDifference',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            
            // Calculadora de Diferença entre Datas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Calculadora de Diferença entre Datas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text('Esta funcionalidade calcularia a diferença entre duas datas.'),
                  const SizedBox(height: 20),
                  // Implementação simplificada - em um app real, teríamos seletores de data
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('Data de Início: 01/01/2023'),
                          const SizedBox(height: 10),
                          const Text('Data de Fim: 31/12/2023'),
                          const SizedBox(height: 10),
                          const Text('Diferença: 364 dias'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Em um app real, abriria seletores de data
                            },
                            child: const Text('Selecionar Datas'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Temporizador e Cronômetro
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Temporizador',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _formatDuration(_timerDuration),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Slider(
                    value: _countdownDuration.inMinutes.toDouble(),
                    min: 1,
                    max: 120,
                    divisions: 119,
                    label: _countdownDuration.inMinutes.toString(),
                    onChanged: (value) {
                      setState(() {
                        _countdownDuration = Duration(minutes: value.toInt());
                        if (!_isTimerRunning) {
                          _timerDuration = _countdownDuration;
                        }
                      });
                    },
                  ),
                  Text(
                    '${_countdownDuration.inMinutes} minutos',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isTimerRunning)
                        ElevatedButton(
                          onPressed: _startTimer,
                          child: const Text('Iniciar'),
                        ),
                      if (_isTimerRunning)
                        ElevatedButton(
                          onPressed: _stopTimer,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('Parar'),
                        ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _resetTimer,
                        child: const Text('Reiniciar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}