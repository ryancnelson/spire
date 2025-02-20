package bundleutil

import (
	"time"

	"gopkg.in/square/go-jose.v2"
)

const (
	// DefaultRefreshHint is the default refresh hint returned from the bundle
	// endpoint. Hard coding for now until we have a grasp on the right
	// strategy.
	DefaultRefreshHint = time.Minute * 10

	x509SVIDUse = "x509-svid"
	jwtSVIDUse  = "jwt-svid"
)

type bundleDoc struct {
	jose.JSONWebKeySet
	Sequence    uint64 `json:"spiffe_sequence,omitempty"`
	RefreshHint int    `json:"spiffe_refresh_hint,omitempty"`
}
