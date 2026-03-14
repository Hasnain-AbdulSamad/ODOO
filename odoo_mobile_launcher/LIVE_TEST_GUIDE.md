# 🧪 LIVE TESTING GUIDE - Odoo Mobile ERP Launcher

## ✅ APP STATUS: RUNNING NOW!

The application is currently running on Chrome. A browser window should be open.

---

## 📍 STEP-BY-STEP TESTING INSTRUCTIONS

### 🔍 **STEP 0: Find the Browser Window**

Look for a Chrome window with:
- Title: "Odoo Mobile ERP" or similar
- URL starting with: `localhost:` or `127.0.0.1:`
- Blue splash screen (initial 2 seconds)

**If you don't see it:**
- Check your taskbar for a new Chrome window
- Look at all open windows (Alt+Tab on Windows)
- The splash screen only shows for 2 seconds, so you might already be on the Server URL screen

---

## 📝 **STEP 1: Server URL Input Screen**

### What You Should See:
```
┌─────────────────────────────────────┐
│   Odoo Mobile ERP                   │
├─────────────────────────────────────┤
│                                     │
│         🔗 (Link Icon)              │
│                                     │
│   Enter Odoo Server URL             │
│   Example: https://your...          │
│                                     │
│   ┌─────────────────────────────┐   │
│   │ Server URL                  │   │
│   │ https://your-company...     │   │
│   └─────────────────────────────┘   │
│                                     │
│   ┌─────────────────────────────┐   │
│   │        Proceed              │   │
│   └─────────────────────────────┘   │
│                                     │
│   Need an Odoo account?             │
│                                     │
└─────────────────────────────────────┘
```

### What To Do:
1. **Click in the "Server URL" text field**
2. **Type exactly**: `https://vmi3035083.contaboserver.net`
3. **Click the blue "Proceed" button**
4. **Wait for validation** (you'll see a loading spinner)

### Expected Result:
- ✅ Loading indicator appears briefly
- ✅ Navigates to Database Selection screen
- ❌ If error: Check the URL is typed correctly

---

## 📝 **STEP 2: Database Selection Screen**

### What You Should See:
```
┌─────────────────────────────────────┐
│   Odoo Mobile ERP                   │
├─────────────────────────────────────┤
│                                     │
│         💾 (Storage Icon)           │
│                                     │
│       Select Database               │
│   Choose the database to connect    │
│                                     │
│   ┌─────────────────────────────┐   │
│   │ Database         ▼          │   │
│   │ test                        │   │
│   └─────────────────────────────┘   │
│                                     │
│   ┌─────────────────────────────┐   │
│   │         Next                │   │
│   └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

### What To Do:
1. **Wait for the database list to load** (should happen automatically)
2. **Click the dropdown** (should already show "test" or you can select it)
3. **Ensure "test" is selected**
4. **Click the blue "Next" button**

### Expected Result:
- ✅ Database list loads successfully
- ✅ "test" database appears in the list
- ✅ Can select "test" from dropdown
- ✅ Navigates to Login screen
- ❌ If error: Server might not be responding to database list API

---

## 📝 **STEP 3: Login Screen**

### What You Should See:
```
┌─────────────────────────────────────┐
│   Odoo Mobile ERP                   │
├─────────────────────────────────────┤
│                                     │
│         👤 (Person Icon)            │
│                                     │
│        Login to Odoo                │
│   Enter your credentials to access  │
│                                     │
│   ┌─────────────────────────────┐   │
│   │ 👤 Username                 │   │
│   │ test                        │   │
│   └─────────────────────────────┘   │
│                                     │
│   ┌─────────────────────────────┐   │
│   │ 🔒 Password          👁      │   │
│   │ ••••                        │   │
│   └─────────────────────────────┘   │
│                                     │
│   ┌─────────────────────────────┐   │
│   │        Login                │   │
│   └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

### What To Do:
1. **Click in the "Username" field**
2. **Type**: `test`
3. **Click in the "Password" field**
4. **Type**: `test`
5. **Optional**: Click the eye icon (👁) to verify password
6. **Click the blue "Login" button**
7. **Wait for authentication** (you'll see a loading spinner)

### Expected Result:
- ✅ Loading indicator appears
- ✅ Authentication succeeds
- ✅ Navigates to Dashboard screen
- ❌ If error: "Invalid username or password" - double-check credentials

---

## 📝 **STEP 4: Dashboard Screen (WebView)**

### What You Should See:
```
┌─────────────────────────────────────┐
│   Odoo Mobile ERP        🔄  ⋮      │
├─────────────────────────────────────┤
│                                     │
│   [Full Odoo Web Interface]         │
│                                     │
│   - Odoo menu bar                   │
│   - Navigation menu                 │
│   - Dashboard widgets               │
│   - All Odoo apps and features      │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

### What To Do:
1. **Verify Odoo interface loads**
2. **Check that you're logged in** (should see Odoo dashboard)
3. **Test navigation**: Click on different Odoo menus
4. **Test refresh**: Click the refresh icon (🔄) in the app bar
5. **Test logout**: Click the menu icon (⋮) → Select "Logout"

### Expected Result:
- ✅ Full Odoo web interface loads
- ✅ Can navigate through Odoo features
- ✅ JavaScript works (interactive elements)
- ✅ Refresh reloads the page
- ✅ Logout returns to Server URL screen

---

## 🔍 **MONITORING FOR ERRORS**

While testing, watch the terminal for any error messages. Common messages you might see:

### ✅ Normal Messages:
```
Flutter run key commands.
r Hot reload.
R Hot restart.
...
```

### ❌ Error Messages to Watch For:
```
[ERROR] Failed to connect...
[ERROR] XMLHttpRequest error...
[ERROR] CORS policy...
[ERROR] Authentication failed...
```

**If you see errors**, please:
1. Copy the entire error message
2. Note which step you were on
3. Take a screenshot if possible
4. Share the information so I can help fix it

---

## 🧪 **ADVANCED TESTING**

### Test 1: Session Persistence
1. Complete the full login flow
2. Get to the dashboard
3. In the terminal, press `q` to quit
4. Run again: `flutter run -d chrome`
5. **Expected**: Should auto-login and go directly to dashboard

### Test 2: Error Handling
1. On Server URL screen, enter invalid URL: `not-a-url`
2. **Expected**: Error message appears
3. On Login screen, enter wrong password: `wrongpassword`
4. **Expected**: "Invalid username or password" error

### Test 3: Navigation
1. In the dashboard, navigate to different Odoo pages
2. Use browser back button (or back gesture)
3. **Expected**: Should navigate back within Odoo first, not exit app immediately

---

## 📊 **WHAT TO REPORT BACK**

Please let me know:

### ✅ If Everything Works:
```
✓ Server URL accepted
✓ Database list loaded (saw "test")
✓ Login successful (test/test)
✓ Dashboard loaded with Odoo interface
✓ Can navigate Odoo features
✓ All features working!
```

### ❌ If Something Fails:
```
✗ Failed at: [Which step?]
✗ Error message: [What did you see?]
✗ Screenshot: [If possible]
✗ Console errors: [Check browser console F12]
```

---

## 🔧 **TROUBLESHOOTING QUICK TIPS**

### Issue: Can't find the browser window
**Solution**:
- Check taskbar for Chrome icon
- Press Alt+Tab to cycle through windows
- Look for window with "localhost" in URL

### Issue: Server URL validation fails
**Solution**:
- Verify: `https://vmi3035083.contaboserver.net`
- Check internet connection
- Try opening the URL in a regular browser first

### Issue: Database list empty or not loading
**Solution**:
- Check terminal for error messages
- Verify server is accessible
- Server might not allow database listing

### Issue: Login fails
**Solution**:
- Double-check: username = `test`, password = `test`
- Verify database `test` was selected
- Check caps lock is off
- Check terminal for authentication errors

### Issue: Dashboard blank or not loading
**Solution**:
- Wait a few more seconds (might be slow connection)
- Check browser console (F12) for errors
- Try clicking refresh button
- Check if session was actually created

---

## 📱 **BROWSER CONSOLE DEBUGGING**

If you encounter issues:

1. **Press F12** in the Chrome window (opens Developer Tools)
2. **Click "Console" tab**
3. **Look for red error messages**
4. **Share any errors you see**

Common things to check:
- Network requests failing (red in Network tab)
- JavaScript errors (red in Console tab)
- CORS errors (Cross-Origin Resource Sharing)

---

## ✅ **SUCCESS CRITERIA**

The test is successful if you can:

1. ✅ Enter your server URL and proceed
2. ✅ See and select the "test" database
3. ✅ Login with test/test credentials
4. ✅ Access the full Odoo web interface
5. ✅ Navigate through Odoo menus and features
6. ✅ Use all Odoo functionality normally

---

## 🎉 **READY TO TEST!**

The app is running and waiting for you to test it!

**Quick reminder of your credentials:**
- Server: `https://vmi3035083.contaboserver.net`
- Database: `test`
- Username: `test`
- Password: `test`

**Please test it now and let me know how it goes!** 🚀

---

*Note: I cannot directly interact with the browser, but I'm monitoring the terminal output and can help troubleshoot any issues you report.*