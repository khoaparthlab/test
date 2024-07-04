enum SystemEnum {
  indentity,
  profile,
  payment,
  websocket,
  tron,
  wallet,
  vault,
  panic;

  String get systemName {
    switch (this) {
      case indentity:
        return 'Indentity';
      case profile:
        return 'Profile';
      case payment:
        return 'Payment';
      case websocket:
        return 'Websocket';
      case tron:
        return 'Tron';
      case wallet:
        return 'Wallet';
      case vault:
        return 'Vault';
      case panic:
        return 'Panic';
      default:
        return 'Indentity';
    }
  }

  String get imageSystem {
    switch (this) {
      case indentity:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/7h1e98kyk9vq/indentity.png';
      case profile:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/tn7ahtq9xjrl/profile.png';
      case payment:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/ak8nmrzte3as/payment.png';
      case websocket:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/vvzq8dzqf9sr/websocket.png';
      case tron:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/vwnoqda08it8/tron.png';
      case wallet:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/ztowqsv90j7u/wallet.png';
      case vault:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/cryptodashboard-mextrb/assets/go9tw3co9xyp/vault.png';
      case panic:
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/PnFplvkDCVz4QGxRUmVs/assets/yw10nsl8pcik/emergency.png';
      default:
        return 'Indentity';
    }
  }
}
