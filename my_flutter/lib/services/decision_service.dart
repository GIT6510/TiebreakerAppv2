import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/decision_result.dart';


class DecisionService extends ChangeNotifier{

  DecisionResult? currentResult;
  bool isLoading = false;
  String? errorMessage;

  final String _apiKey = "AIzaSyBpASoRU4xVubLkCZ7nOt60izDawPnuk1o";

  Future<void> analyzeDecision(String decisionPrompt) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
      final prompt = ''' 
      
      you are an expert decison making assistant. the user is trying to make a decision:"$decisionPrompt".
      please provide exactly 3 section of markdown
      1. ### pros and cons
      provide a detailed pros and cons list/
      2.### Comparison table
      if applicable, provide a comparison table comparing the main alternatives
      3.### SWOT analysis
      provide a SWOT (Strenghts, Weaknesses, Oppotunities, Threats) analysis for the decision
      
      ensure the markdown is well-formatted and easy to read. do not include extra text outside of these header.
      ''';

      // final content = [Content.text(prompt)];
      // final response = await model.generateContent(content);
      //
      // final text = response.text ?? '';
      //
      // final section = _parseResponse(text, decisionPrompt);

      final response = await model.generateContent([Content.text(prompt)]);
      currentResult = _parseResponse(response.text ?? '', decisionPrompt);

    }catch(e){
      errorMessage = 'Failed $e';

    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  DecisionResult _parseResponse(String text, String decision){
    final parts = text.split('###');
    return DecisionResult(
        decision: decision,
        prosAndCons: parts.length >1? parts[1] : text,
        comparisonTable: parts.length >2? parts[2] : "no table",
        swotAnalysis: parts.length >3? parts[3] : "no swot",
    );
  }
}
