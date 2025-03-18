#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#define int long long
#define float long double
#define ff first
#define ss second
#define oyes cout << "YES" << endl;
#define ono cout << "NO" << endl;
#define vi vector<int>
#define vpi vector<pair<int, int>>
#define vvi vector<vector<int>>
#define mii map<int, int>
#define all(a) a.begin(), a.end()
#define vin(v, n)               \
    int x;                      \
    for (int i = 0; i < n; i++) \
    {                           \
        cin >> x;               \
        v.push_back(x);         \
    }
#define dis(s, n)         \
    for (int i : s)       \
    {                     \
        cout << i << " "; \
    }                     \
    cout << "\n";
using namespace std;
using namespace __gnu_pbds;
typedef tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update> ordered_set;// find_by_order, order_of_key
vector<int> sexp(int n)
{
    int *arr = new int[n + 1]();
    vector<int> vect;
    for (int i = 2; i <= n; i++)
        if (arr[i] == 0)
        {
            vect.push_back(i);
            for (int j = 2 * i; j <= n; j += i)
                arr[j] = 1;
        }
    return vect;
}
#ifndef ONLINE_JUDGE
#define cerr(x) cerr << #x << ':' << x << '\n';
#define verr(v)            \
    cerr << #v << " [ ";   \
    for (auto &x : v)      \
        cerr << x << ", "; \
    cerr << "]\n";
#define serr(s)            \
    cerr << #s << " { ";   \
    for (auto &x : s)      \
        cerr << x << ", "; \
    cerr << "}\n";
#define vperr(vp)                          \
    cerr << #vp << "[\n";                  \
    for (auto &x : vp)                     \
        cerr << x.ff << ' ' << x.ss << '\n'; \
    cerr << "]\n";
#define vverr(vv)             \
    cerr << #vv << "[\n";     \
    for (auto &x : vv)        \
    {                         \
        cerr << "[ ";         \
        for (auto &y : x)     \
            cerr << y << ' '; \
        cerr << "]\n";        \
    }                         \
    cerr << "]";
#else
#define cerr(x) ;
#define verr(x) ;
#define serr(x) ;
#define vperr(vp) ;
#define vverr(vv) ;
#endif

void decToBinary(int n)
{
    vi bin(32, 0);
    int i = 0;
    while (n > 0)
    {
        bin[i] = n % 2;
        n = n / 2;
        i++;
    }
    for (int j = i - 1; j >= 0; j--)
        cout << bin[j];
}

long long exp(long long a, long long b)
{
    long long res = 1;
    while (b > 0)
    {
        if (b & 1)
        {
            res = res * a;
        }
        a = a * a;
        b >>= 1;
    }
    return res;
}

long long exp1(long long a, long long b)
{
    long long mod = 1e9 + 7;
    a %= mod;
    long long res = 1;
    while (b > 0)
    {
        if (b & 1)
        {
            res = res * a % mod;
        }
        a = a * a % mod;
        b >>= 1;
    }
    return res;
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);
    int t, n;
    cin >> t;
    while (t--)
    {
        cin >> n;
        //vi a(n, 0);for (int i = 0; i < n; i++){cin >> a[i];}
        
    }
return 0;
}