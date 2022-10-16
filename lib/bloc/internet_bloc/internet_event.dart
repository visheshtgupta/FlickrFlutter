part of 'internet_bloc.dart';

abstract class InternetEvent {}

class InternetGainedEvent extends InternetEvent {}

class InternetLostEvent extends InternetEvent {}
