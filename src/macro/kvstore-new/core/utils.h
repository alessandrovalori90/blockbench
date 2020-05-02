//
//  utils.h
//  YCSB-C
//
//  Created by Jinglei Ren on 12/5/14.
//  Copyright (c) 2014 Jinglei Ren <jinglei@ren.systems>.
//

#ifndef YCSB_C_UTILS_H_
#define YCSB_C_UTILS_H_

#include <cstdint>
#include <random>
#include <algorithm>
#include <exception>
#include <atomic>
class SpinLock {
  std::atomic_flag locked = ATOMIC_FLAG_INIT;

 public:
  void lock() {
    while (locked.test_and_set(std::memory_order_acquire)) {
      ;
    }
  }
  void unlock() { locked.clear(std::memory_order_release); }
};

namespace utils {

const uint64_t kFNVOffsetBasis64 = 0xCBF29CE484222325;
const uint64_t kFNVPrime64 = 1099511628211;

const uint64_t kFNVOffsetBasis32 = 0x811c9dc5;
const uint64_t kFNVPrime32 = 16777619;

//Fowler–Noll–Vo hash function
inline uint64_t FNVHash64(uint64_t val) {
  uint64_t hash = kFNVOffsetBasis64;

  for (int i = 0; i < 8; i++) {
    uint64_t octet = val & 0x00ff; // 0x00ff in binary is 11111111 and does binary AND operations with val(Takes in considerations the last 8 bits).
    val = val >> 8; //removes the last 8 bits

    hash = hash ^ octet;
    hash = hash * kFNVPrime64;
  }
  return hash;
}

//added the 32 bit version
inline uint64_t FNVHash32(uint32_t val) {
  uint64_t hash = kFNVOffsetBasis32;

  for (int i = 0; i < 4; i++) {
    uint64_t octet = val & 0xff; // 0xff in binary is 11111111 and does binary AND operations with val(Takes in considerations the last 8 bits).
    val = val >> 8; //removes the last 8 bits

    hash = hash ^ octet;
    hash = hash * kFNVPrime32;
  }
  return hash;
}

inline uint64_t Hash(uint64_t val) { return FNVHash64(val); }
inline uint64_t Hash(uint32_t val) { return FNVHash32(val); }

inline double RandomDouble(double min = 0.0, double max = 1.0) {
  static std::default_random_engine generator;
  static std::uniform_real_distribution<double> uniform(min, max);
  return uniform(generator);
}

///
/// Returns an ASCII code that can be printed to desplay
///
inline char RandomPrintChar() {
  return rand() % 94 + 33;
}

class Exception : public std::exception {
 public:
  Exception(const std::string &message) : message_(message) { }
  const char* what() const noexcept {
    return message_.c_str();
  }
 private:
  std::string message_;
};

inline bool StrToBool(std::string str) {
  std::transform(str.begin(), str.end(), str.begin(), ::tolower);
  if (str == "true" || str == "1") {
    return true;
  } else if (str == "false" || str == "0") {
    return false;
  } else {
    throw Exception("Invalid bool string: " + str);
  }
}

inline std::string Trim(const std::string &str) {
  auto front = std::find_if_not(str.begin(), str.end(), [](int c){ return std::isspace(c); });
  return std::string(front, std::find_if_not(str.rbegin(), std::string::const_reverse_iterator(front),
      [](int c){ return std::isspace(c); }).base());
}

} // utils

#endif // YCSB_C_UTILS_H_
