import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor UserAdminManager {

    type User = {
        username: Text;
        password: Text;
    };

    type Admin = {
        username: Text;
        password: Text;
    };

    // ======================== User Management ======================== 
    stable var userBuffer: [(Text, User)] = [];
    var users: HashMap.HashMap<Text, User> = HashMap.HashMap<Text, User>(
        10, Text.equal, Text.hash
    );

    public func registerUser(username: Text, password: Text): async Text {
        if (users.get(username) != null) {
            return "⚠️ Username sudah terdaftar!";
        };

        let newUser: User = { username = username; password = password };
        users.put(username, newUser);

        return "✅ Registrasi user berhasil!";
    };

    public func loginUser(username: Text, password: Text): async Text {
        switch (users.get(username)) {
            case (null) { return "❌ User tidak ditemukan!"; };
            case (?user) {
                if (user.password == password) {
                    return "✅ Login sukses!";
                } else {
                    return "❌ Password salah!";
                };
            };
        };
    };

    public func isUserExists(username: Text): async Bool {
        return users.get(username) != null;
    };

    // ======================== Admin Management ======================== 
    stable var adminBuffer: [(Text, Admin)] = [];
    var admins: HashMap.HashMap<Text, Admin> = HashMap.HashMap<Text, Admin>(
        5, Text.equal, Text.hash
    );

    public func registerAdmin(username: Text, password: Text): async Text {
        if (admins.get(username) != null) {
            return "⚠️ Admin sudah terdaftar!";
        };

        let newAdmin: Admin = { username = username; password = password };
        admins.put(username, newAdmin);

        return "✅ Registrasi admin berhasil!";
    };

    public func loginAdmin(username: Text, password: Text): async Text {
        switch (admins.get(username)) {
            case (null) { return "❌ Admin tidak ditemukan!"; };
            case (?admin) {
                if (admin.password == password) {
                    return "✅ Login admin sukses!";
                } else {
                    return "❌ Password admin salah!";
                };
            };
        };
    };

    public func isAdminExists(username: Text): async Bool {
        return admins.get(username) != null;
    };
};
